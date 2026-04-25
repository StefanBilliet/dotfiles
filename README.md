# Dotfiles

For OpenCode + Linear, set `LINEAR_API_KEY` through a macOS LaunchAgent so Dock/Finder-launched apps can see it.

Create `~/Library/LaunchAgents/com.stefanbilliet.linear-api-key.plist` with `RunAtLoad=true` and a command that runs:

Read the secret from your private 1Password item and pass it to `launchctl setenv LINEAR_API_KEY`.

After updating the LaunchAgent, restart OpenCode.
