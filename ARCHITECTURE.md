# Architecture

The Discord Release Notifier is a GitHub Action workflow triggered by the `release` event, specifically when a new release is *published*. It constructs a JSON payload containing information about the release and sends it to a specified Discord webhook URL, resulting in a formatted embed message in the Discord channel.

## Components

1.  **GitHub Actions Workflow (`.github/workflows/release-notification.yml`):**

    *   Defines the workflow's triggers, jobs, and steps.
    *   Utilizes environment variables to access sensitive information (webhook URL) and dynamic release data (release name, URL, body).
    *   Constructs the JSON payload for the Discord embed.
    *   Uses the `curl` command to send the HTTP POST request to the Discord webhook.

2.  **Discord Webhook:**

    *   A URL provided by Discord that allows external applications to send messages to a specific channel.
    *   Requires a JSON payload formatted according to the Discord API.

## Data Flow

1.  A user publishes a new release in the GitHub repository.
2.  GitHub Actions detects the `release` event and triggers the `release-notification.yml` workflow.
3.  The workflow retrieves the release information and constructs the JSON payload.
4.  The workflow sends an HTTP POST request to the Discord webhook URL with the JSON payload.
5.  Discord receives the request and displays the formatted embed message in the specified channel.

## Future Considerations

*   **Error Handling:** Implement more robust error handling, such as retries and logging.
*   **Customization:** Allow users to customize the embed message through workflow inputs.
*   **Testing:** Add unit and integration tests to ensure the workflow functions correctly.
