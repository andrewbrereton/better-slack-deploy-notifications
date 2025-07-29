#!/bin/bash
set -e

# Ensure jq is available (it's pre-installed on GitHub runners)
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not found"
    exit 1
fi

# Set up common variables
export SHORT_SHA=$(echo $GITHUB_SHA | cut -c1-7)
export COMMIT_MSG=$(git log -1 --pretty=format:'%s' 2>/dev/null || echo "Initial commit")
export CURRENT_TIME=$(date -u +%Y-%m-%dT%H:%M:%SZ)
export CURRENT_TIMESTAMP=$(date +%s)

# Calculate duration for success/failure cases
if [ -n "$START_TIMESTAMP" ]; then
    DURATION=$((CURRENT_TIMESTAMP - START_TIMESTAMP))
    export DURATION_MIN=$((DURATION / 60))
    export DURATION_SEC=$((DURATION % 60))
    export DURATION_TEXT="${DURATION_MIN}m ${DURATION_SEC}s"
else
    export DURATION_TEXT="Unknown"
fi

# Function to process template with environment variables
process_template() {
    local template_file="$1"
    envsubst < "$ACTION_PATH/templates/$template_file" | jq -c '.'
}

# Function to send Slack API request
slack_api() {
    local method="$1"
    local payload="$2"

    curl -s -X POST "https://slack.com/api/$method" \
        -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
        -H "Content-Type: application/json" \
        -d "$payload"
}

# Main logic
case "$DEPLOYMENT_STATUS" in
    "start")
        echo "🚀 Sending deployment start notification..."

        # Store start time for duration calculation
        echo "START_TIMESTAMP=$CURRENT_TIMESTAMP" >> $GITHUB_ENV

        # Send initial notification
        payload=$(process_template "start.json")
        response=$(slack_api "chat.postMessage" "$payload")

        # Extract and output message timestamp
        message_ts=$(echo "$response" | jq -r '.ts')
        if [ "$message_ts" = "null" ]; then
            echo "Error: Failed to send Slack message"
            echo "Response: $response"
            exit 1
        fi

        echo "message-timestamp=$message_ts" >> $GITHUB_OUTPUT
        echo "MESSAGE_TS=$message_ts" >> $GITHUB_ENV

        # Get workspace domain for message URL
        team_info=$(slack_api "team.info" "{}")
        workspace_domain=$(echo "$team_info" | jq -r '.team.domain')
        message_url="https://$workspace_domain.slack.com/archives/$CHANNEL_ID/p$(echo $message_ts | tr -d '.')"
        echo "message-url=$message_url" >> $GITHUB_OUTPUT

        echo "✅ Start notification sent: $message_url"
        ;;

    "progress")
        echo "🔄 Updating deployment progress: $STEP_NAME..."

        payload=$(process_template "progress.json")
        slack_api "chat.update" "$payload"

        # Add thread update
        thread_payload=$(jq -n \
            --arg channel "$CHANNEL_ID" \
            --arg thread_ts "$MESSAGE_TS" \
            --arg text "🔄 $STEP_NAME step in progress..." \
            '{channel: $channel, thread_ts: $thread_ts, text: $text}')
        slack_api "chat.postMessage" "$thread_payload"

        echo "✅ Progress updated: $STEP_NAME"
        ;;

    "success")
        echo "✅ Sending deployment success notification..."

        payload=$(process_template "success.json")
        slack_api "chat.update" "$payload"

        # Add success reaction
        reaction_payload=$(jq -n \
            --arg channel "$CHANNEL_ID" \
            --arg timestamp "$MESSAGE_TS" \
            --arg name "white_check_mark" \
            '{channel: $channel, timestamp: $timestamp, name: $name}')
        slack_api "reactions.add" "$reaction_payload"

        # Add success thread
        thread_payload=$(jq -n \
            --arg channel "$CHANNEL_ID" \
            --arg thread_ts "$MESSAGE_TS" \
            --arg duration "$DURATION_TEXT" \
            --arg workflow_url "$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID" \
            --arg commit_url "$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/commit/$GITHUB_SHA" \
            --arg repo_url "$GITHUB_SERVER_URL/$GITHUB_REPOSITORY" \
            '{
                channel: $channel,
                thread_ts: $thread_ts,
                text: ("✅ **Deployment completed successfully in " + $duration + "**\n\n🔗 **Quick Links:**\n• [Workflow Results](" + $workflow_url + ")\n• [Deployed Commit](" + $commit_url + ")\n• [Repository](" + $repo_url + ")")
            }')
        slack_api "chat.postMessage" "$thread_payload"

        echo "✅ Success notification sent ($DURATION_TEXT)"
        ;;

    "failure")
        echo "❌ Sending deployment failure notification..."

        payload=$(process_template "failure.json")
        slack_api "chat.update" "$payload"

        # Add failure reaction
        reaction_payload=$(jq -n \
            --arg channel "$CHANNEL_ID" \
            --arg timestamp "$MESSAGE_TS" \
            --arg name "x" \
            '{channel: $channel, timestamp: $timestamp, name: $name}')
        slack_api "reactions.add" "$reaction_payload"

        # Add detailed failure thread
        thread_payload=$(jq -n \
            --arg channel "$CHANNEL_ID" \
            --arg thread_ts "$MESSAGE_TS" \
            --arg step_name "$STEP_NAME" \
            --arg repository "$GITHUB_REPOSITORY" \
            --arg branch "$GITHUB_REF_NAME" \
            --arg actor "$GITHUB_ACTOR" \
            --arg environment "$ENVIRONMENT" \
            --arg failed_time "$CURRENT_TIME" \
            --arg duration "$DURATION_TEXT" \
            --arg workflow_url "$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID" \
            --arg commit_url "$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/commit/$GITHUB_SHA" \
            --arg repo_url "$GITHUB_SERVER_URL/$GITHUB_REPOSITORY" \
            '{
                channel: $channel,
                thread_ts: $thread_ts,
                text: ("❌ **Deployment Failure Details**\n\n**Failed Step:** " + $step_name + "\n**Repository:** " + $repository + "\n**Branch:** " + $branch + "\n**Actor:** " + $actor + "\n**Environment:** " + $environment + "\n**Failed At:** " + $failed_time + "\n**Duration:** " + $duration + "\n\n**🔍 Debug Links:**\n• [Workflow Logs](" + $workflow_url + ")\n• [Failed Commit](" + $commit_url + ")\n• [Repository](" + $repo_url + ")\n\n**📋 Next Steps:**\n1. Check workflow logs for specific error details\n2. Review the failing commit for issues\n3. Consider rolling back if this affects " + $environment)
            }')
        slack_api "chat.postMessage" "$thread_payload"

        echo "❌ Failure notification sent (failed after $DURATION_TEXT)"
        ;;

    *)
        echo "Error: Invalid deployment-status '$DEPLOYMENT_STATUS'. Use: start, progress, success, failure"
        exit 1
        ;;
esac