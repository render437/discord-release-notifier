# Discord Release Notifier

[![Actions Status](https://github.com/<YOUR_GITHUB_USERNAME>/discord-release-notifier/workflows/Discord%20Release%20Notification/badge.svg)](https://github.com/<YOUR_GITHUB_USERNAME>/discord-release-notifier/actions)

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

4.  **Create a Release.**  Whenever you create and publish a new release in your repository, this workflow will automatically trigger and send a notification to your Discord channel.

## `.github/workflows/release-notification.yml` Explanation

This file defines the GitHub Actions workflow.  Here's a breakdown:

*   **`name: Discord Release Notification`**:  The name of the workflow, displayed in the GitHub Actions tab.
*   **`on: release: types: [published]`**:  The workflow is triggered when a new release is *published*.
*   **`jobs: notify:`**: Defines a job named "notify" to encapsulate the workflow's steps.
*   **`runs-on: ubuntu-latest`**: Specifies the workflow runs on the latest version of Ubuntu.
*   **`steps:`**:  A list of steps to execute.
    *   **`name: Send Discord Notification`**:  A descriptive name for this step.
    *   **`env:`**: Defines environment variables:
        *   `DISCORD_WEBHOOK`:  Retrieved from the repository's secret.
        *   `RELEASE_NAME`, `RELEASE_URL`, `RELEASE_BODY`, `REPO_NAME`: Extract release information from the `github.event` context.  The `github.event` contains data about the event triggering the workflow.
        *   `COMMIT_SHA`: The SHA of the commit tagged by the release.
        *   `ACTOR`: The GitHub username of the person creating the release.
    *   **`run: |`**:  Executes a shell script.
        *   `PAYLOAD=$(cat <<EOF ... EOF)`:  Creates the JSON payload for the Discord embed.  Uses a "here document" for easier multi-line string definition.
        *   The JSON payload contains:
            *   `embeds`: An array (with one element in this case) representing the Discord embed.
            *   `title`: The release name.
            *   `url`: A link to the release page.
            *   `description`: The release notes.
            *   `color`: The color of the embed (5814783 is a light blue/aqua).
            *   `footer`:  The repository name.
            *   `fields`:  Additional fields in the embed:
                *   `Created By`: The GitHub username of the person creating the release.
                *   `Commit`: The SHA of the commit tagged by the release.
        *   `curl -H "Content-Type: application/json" -d "$PAYLOAD" "$DISCORD_WEBHOOK"`: Sends the JSON payload to Discord.  The `-H` flag sets the Content-Type header, and `-d` specifies the request body (the JSON payload).

## Example Discord Message

After a new release, your Discord channel will receive an embed like this:

![Image](https://image.pollinations.ai/prompt/example%20Discord%20embed%20message%20for%20a%20release,%20with%20title,%20description,%20url,%20footer,%20author%20and%20commit%20fields,%20clean%20and%20professional%20design)

## License

[MIT License](LICENSE)

## Contributing

Contributions are welcome! Please feel free to submit pull requests.
