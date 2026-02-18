# Discord Release Notifier

[![Actions Status](https://github.com/render437/discord-release-notifier/workflows/Discord%20Release%20Notification/badge.svg)](https://github.com/render437/discord-release-notifier/actions)

A GitHub Action workflow to send Discord notifications via webhook when a new release is published.

## Features

*   **Discord Embeds:** Sends formatted release information as an embed in Discord.
*   **Release Information:** Includes the release name, URL, description (release notes), repository name, the user who created the release and the SHA of the commit tagged by the release.
*   **Easy Setup:** Simply add the Discord webhook as a repository secret.
*   **Customizable:**  You can easily customize the embed message formatting.

## Usage

1.  **Fork this repository.**  Click the "Fork" button in the top right corner.
2.  **Add the `DISCORD_WEBHOOK` secret.**
    *   Go to your forked repository's settings.
    *   Click on "Secrets" -> "Actions".
    *   Add a new repository secret named `DISCORD_WEBHOOK`.
    *   Set the value to your Discord webhook URL.  **Important:** Make sure the webhook URL is valid!
3.  **(Optional) Customize the workflow.** Edit the `.github/workflows/release-notification.yml` file to modify the embed content, color, or add additional fields.  See the Discord API documentation for available options: [https://discord.com/developers/docs/resources/channel#embed-object](https://discord.com/developers/docs/resources/channel#embed-object)

4.  **(Optional) Setup Vercel Deployment.** This template comes with a `vercel.json` configuration file which enables the build to be automatically deployed to a Vercel project. To use this feature, setup the project under the Vercel platform.

5.  **(Optional) Customize EditorConfig.** Customize your code and text editors using the settings specified under the `.editorconfig` file.

6.  **(Optional) Modify Default Settings.** If needed, modify the settings under the `settings.example.json` file. This can be used to modify settings for your personal fork, and for users in development.

7.  **Create a Release.**  Whenever you create and publish a new release in your repository, this workflow will automatically trigger and send a notification to your Discord channel.

---

### `.github/workflows/release-notification.yml Example`

```yaml
name: Discord Release Notification

on:
  release:
    types: [published]

jobs:
  notify:
    runs-on: ubuntu-latest
    steps:
      - name: Send Discord Notification
        env:
          DISCORD_WEBHOOK: ${{ secrets.DISCORD_WEBHOOK }}
          RELEASE_NAME: ${{ github.event.release.name }}
          RELEASE_URL: ${{ github.event.release.html_url }}
          RELEASE_BODY: ${{ github.event.release.body }}
          REPO_NAME: ${{ github.repository }}
          COMMIT_SHA: ${{ github.sha }} # Add Commit SHA for the release commit.
          ACTOR: ${{ github.actor }}      # Username of the person creating release.
        run: |
          # Construct the JSON payload for the embed
          PAYLOAD=$(cat <<EOF
          {
            "embeds": [{
              "title": "New Release: $RELEASE_NAME",
              "url": "$RELEASE_URL",
              "description": "$RELEASE_BODY",
              "color": 5814783, # A nice light blue/aqua color,
              "footer": {
                "text": "Release from $REPO_NAME"
              },
              "fields": [
                {
                  "name": "Created By",
                  "value": "$ACTOR",
                  "inline": true
                },
                {
                  "name": "Commit",
                  "value": "$COMMIT_SHA",
                  "inline": true
                }
              ]
            }]
          }
          EOF
          )

          # Send the message to Discord via webhook
          curl -H "Content-Type: application/json" -d "$PAYLOAD" "$DISCORD_WEBHOOK"
```

## Example Discord Message

After a new release, your Discord channel will receive an embed like this:

![Image](https://image.pollinations.ai/prompt/example%20Discord%20embed%20message%20for%20a%20release,%20with%20title,%20description,%20url,%20footer,%20author%20and%20commit%20fields,%20clean%20and%20professional%20design)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to 437render@gmail.com

## Security

See [SECURITY.md](SECURITY.md) for our security policy.

## License

[MIT License](LICENSE)
