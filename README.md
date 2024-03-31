# Simple Telegram Bot With Dart 

This repository contains a simple Telegram bot using the Teledart library in Dart.

## Core Features

- When a new user starts the bot, their ID is stored in a file.
- When the admin sends the `/broadcast` command, the bot asks the admin for the message they want to broadcast.
- Once the message is received, the bot sends the message to all users.

## How to Run

1. Install Dart if not already installed.
2. Clone the repository to your local machine using `git clone`.
3. Navigate to the project directory using `cd <directory>`.
4. Run the bot using `dart run`.

## Notes

- You need to replace `'admin'` with the actual admin username in the code.
- Make sure to handle the user IDs and bot token securely.
