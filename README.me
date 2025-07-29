# Better Slack Deployment Notifications

[![GitHub release](https://img.shields.io/github/release/andrewbrereton/better-slack-deploy-notifications.svg)](https://GitHub.com/andrewbrereton/better-slack-deploy-notifications/releases/)
[![GitHub license](https://img.shields.io/github/license/andrewbrereton/better-slack-deploy-notifications.svg)](https://github.com/andrewbrereton/better-slack-deploy-notifications/blob/main/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/andrewbrereton/better-slack-deploy-notifications.svg)](https://GitHub.com/andrewbrereton/better-slack-deploy-notifications/issues/)

A professional GitHub Action for sending real-time deployment notifications to Slack with progress tracking, rich formatting, and comprehensive error handling.

## Features

🚀 **Real-time Updates** - Updates the same message throughout deployment lifecycle
📱 **Rich Formatting** - Professional Slack Block Kit layouts with actionable buttons
⚡ **Fast Performance** - Lightweight shell-based implementation
🔧 **Easy Setup** - Works with official Slack apps (no deprecated webhooks)
🎯 **Flexible** - Supports multiple environments and custom messaging
🛠 **Reliable** - Comprehensive error handling and fallback scenarios
🔒 **Secure** - Uses OAuth tokens with proper scoping

## Quick Start

### 1. Slack App Setup

1. **Create Slack App**: Go to [api.slack.com/apps](https://api.slack.com/apps) → "Create New App" → "From scratch"

2. **Add Bot User**: Navigate to "App Home" → Enable "App Home" tab → Toggle "Allow users to send Slash commands and messages from the messages tab"

3. **Set OAuth Scopes**: Go to "OAuth & Permissions", add these Bot Token Scopes:
   ```
   chat:write
   chat:write.public
   channels:read
   reactions:write
   ```

4. **Install to Workspace**: Click "Install to Workspace" → Copy the "Bot User OAuth Token" (starts with `xoxb-`)

5. **Get Channel ID**: In Slack, right-click your deployment channel → "Copy link" → Extract channel ID from URL (format: `C1234567890`)

### 2. GitHub Repository Setup

Add these secrets to your repository settings:

- `SLACK_BOT_TOKEN`: Your bot OAuth token from step 4
- `SLACK_CHANNEL_ID`: Your channel ID from step 5 (optional, can be passed as input)

### 3. Basic Usage

```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # Start deployment notification
      - name: Notify Deployment Start
        id: slack-start
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ secrets.SLACK_CHANNEL_ID }}
          deployment-status: 'start'
          environment: 'production'

      # Your deployment steps...
      - name: Deploy Application
        run: |
          echo "Deploying application..."
          # Your deployment commands here

      # Success notification
      - name: Notify Success
        if: success()
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ secrets.SLACK_CHANNEL_ID }}
          deployment-status: 'success'
          message-timestamp: ${{ steps.slack-start.outputs.message-timestamp }}

      # Failure notification
      - name: Notify Failure
        if: failure()
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ secrets.SLACK_CHANNEL_ID }}
          deployment-status: 'failure'
          message-timestamp: ${{ steps.slack-start.outputs.message-timestamp }}
```

## Inputs

| Input | Required | Default | Description |
|-------|----------|---------|-------------|
| `slack-bot-token` | ✅ | | Slack bot OAuth token (xoxb-...) |
| `channel-id` | ✅ | | Slack channel ID for notifications |
| `deployment-status` | ✅ | | Deployment status: `start`, `progress`, `success`, `failure` |
| `message-timestamp` | | | Message timestamp for updates (from start notification) |
| `step-name` | | `Deployment` | Current deployment step name |
| `environment` | | `production` | Deployment environment |
| `custom-message` | | | Custom message to include in notification |

## Outputs

| Output | Description |
|--------|-------------|
| `message-timestamp` | Slack message timestamp for subsequent updates |
| `message-url` | Direct URL to the Slack message |

## Complete Examples

### Simple Deployment

```yaml
name: Simple Deploy
on:
  push:
    branches: [main]

env:
  SLACK_CHANNEL: 'C1234567890'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Start Notification
        id: notify
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ env.SLACK_CHANNEL }}
          deployment-status: 'start'

      - name: Deploy
        run: |
          echo "Deploying..."
          sleep 10

      - name: Success Notification
        if: success()
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ env.SLACK_CHANNEL }}
          deployment-status: 'success'
          message-timestamp: ${{ steps.notify.outputs.message-timestamp }}

      - name: Failure Notification
        if: failure()
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ env.SLACK_CHANNEL }}
          deployment-status: 'failure'
          message-timestamp: ${{ steps.notify.outputs.message-timestamp }}
```

### Multi-Step Deployment with Progress Updates

```yaml
name: Advanced Deploy
on:
  push:
    branches: [main]

env:
  SLACK_CHANNEL: 'C1234567890'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # Initial notification
      - name: Start Deployment
        id: start-notify
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ env.SLACK_CHANNEL }}
          deployment-status: 'start'
          environment: 'production'
          custom-message: 'Rolling out new features v2.1.0'

      # Build phase
      - name: Build Application
        run: |
          echo "Building application..."
          sleep 30

      - name: Update - Build Complete
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ env.SLACK_CHANNEL }}
          deployment-status: 'progress'
          message-timestamp: ${{ steps.start-notify.outputs.message-timestamp }}
          step-name: 'Build Complete ✅'

      # Test phase
      - name: Run Tests
        run: |
          echo "Running tests..."
          sleep 20

      - name: Update - Tests Complete
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ env.SLACK_CHANNEL }}
          deployment-status: 'progress'
          message-timestamp: ${{ steps.start-notify.outputs.message-timestamp }}
          step-name: 'Tests Passed ✅'

      # Deploy phase
      - name: Deploy to Production
        id: deploy
        run: |
          echo "Deploying to production..."
          sleep 45

      - name: Update - Deploy Complete
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ env.SLACK_CHANNEL }}
          deployment-status: 'progress'
          message-timestamp: ${{ steps.start-notify.outputs.message-timestamp }}
          step-name: 'Production Deploy ✅'

      # Final notifications
      - name: Success Notification
        if: success()
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ env.SLACK_CHANNEL }}
          deployment-status: 'success'
          message-timestamp: ${{ steps.start-notify.outputs.message-timestamp }}

      - name: Failure Notification
        if: failure()
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ env.SLACK_CHANNEL }}
          deployment-status: 'failure'
          message-timestamp: ${{ steps.start-notify.outputs.message-timestamp }}
          step-name: ${{ steps.deploy.conclusion == 'failure' && 'Production Deploy' || 'Build/Test' }}
```

### Multi-Environment Deployment

```yaml
name: Multi-Environment Deploy
on:
  push:
    branches: [main]

strategy:
  matrix:
    environment: [staging, production]
    include:
      - environment: staging
        channel: 'C1111111111'
      - environment: production
        channel: 'C2222222222'

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: ${{ matrix.environment }}
    steps:
      - uses: actions/checkout@v4

      - name: Start Deployment
        id: notify
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ matrix.channel }}
          deployment-status: 'start'
          environment: ${{ matrix.environment }}

      - name: Deploy to ${{ matrix.environment }}
        run: |
          echo "Deploying to ${{ matrix.environment }}..."
          # Environment-specific deployment logic

      - name: Success Notification
        if: success()
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ matrix.channel }}
          deployment-status: 'success'
          message-timestamp: ${{ steps.notify.outputs.message-timestamp }}

      - name: Failure Notification
        if: failure()
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ matrix.channel }}
          deployment-status: 'failure'
          message-timestamp: ${{ steps.notify.outputs.message-timestamp }}
```

## Message Examples

### Start Notification
![Start notification example showing deployment initiation with repository info, actor, and commit]

### Progress Update
![Progress notification showing current step status]

### Success Notification
![Success notification with execution time and action buttons]

### Failure Notification
![Failure notification with debug links and error details]

## Troubleshooting

### Common Issues

**❌ "Invalid channel" error**
- Ensure your bot is added to the target channel
- Verify the channel ID format (should start with 'C')
- Check that your bot has `chat:write.public` scope

**❌ "Token invalid" error**
- Verify your `SLACK_BOT_TOKEN` is correct and starts with `xoxb-`
- Ensure the token hasn't been regenerated in Slack
- Check that all required OAuth scopes are granted

**❌ "Message not found" for updates**
- Ensure you're passing the `message-timestamp` from the start notification
- Verify the same channel is being used for all updates
- Check that the original message wasn't deleted

**❌ Missing commit information**
- Ensure `actions/checkout@v4` runs before the notification step
- For shallow clones, you may need `fetch-depth: 0`

**❌ Duration shows "Unknown"**
- This happens when `START_TIMESTAMP` environment variable is lost
- Ensure the same job handles start and end notifications
- For multi-job workflows, pass timing data through job outputs

### Debug Mode

Enable debug logging by setting the `ACTIONS_STEP_DEBUG` secret to `true` in your repository settings.

### Testing Your Setup

Test your Slack integration with a simple workflow:

```yaml
name: Test Slack Notifications
on:
  workflow_dispatch:

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Test Notification
        uses: andrewbrereton/better-slack-deploy-notifications@v1
        with:
          slack-bot-token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel-id: ${{ secrets.SLACK_CHANNEL_ID }}
          deployment-status: 'start'
          environment: 'test'
          custom-message: 'Testing Slack integration'
```

## Security Best Practices

- ✅ Store Slack tokens as repository secrets, never in code
- ✅ Use the minimum required OAuth scopes
- ✅ Regularly rotate your Slack bot tokens
- ✅ Consider using environment-specific tokens for production deployments
- ✅ Review Slack app permissions periodically

## Versioning

We use [Semantic Versioning](http://semver.org/). For available versions, see the [tags on this repository](https://github.com/andrewbrereton/better-slack-deploy-notifications/tags).

### Recommended Usage

- **Latest stable**: `andrewbrereton/better-slack-deploy-notifications@v1`
- **Specific version**: `andrewbrereton/better-slack-deploy-notifications@v1.2.3`
- **Latest (potentially breaking)**: `andrewbrereton/better-slack-deploy-notifications@main`

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Setup

```bash
git clone https://github.com/andrewbrereton/better-slack-deploy-notifications.git
cd slack-deploy-notify
chmod +x scripts/*.sh

# Test locally (requires environment variables)
export SLACK_BOT_TOKEN="xoxb-your-token"
export CHANNEL_ID="C1234567890"
export DEPLOYMENT_STATUS="start"
export GITHUB_REPOSITORY="test/repo"
export GITHUB_ACTOR="testuser"
# ... other required env vars

./scripts/notify.sh
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
