### README

# Customizable Task Management System (CTMS)

**CTMS** is a mobile app designed to help small businesses manage their tasks better. With CTMS, users can create task templates, track employee progress, and improve their workflows. The system is flexible and can be customized to fit different business needs.

## Features
- **Customizable Templates**: Create templates with fields and roles to fit your tasks. You can add different fields (like text, dates, or numbers) and assign roles to people involved in the tasks.
- **User Roles and Permissions**: Define roles for users and decide who can edit or view the task details.
- **Task Tracking**: Easily track tasks and see the progress with a simple and clear interface.
- **Email Authentication**: Secure user sign-up and login to keep your data safe.
- **Map Integration**: Track the location of tasks or employees on a map for better organization.

## How It Works
CTMS is built using **Flutter** for the user interface and **Serverpod** for backend services. The database uses **PostgreSQL** to store data, and everything runs on **Docker** for easy deployment.

## How to Set Up the Project
Follow these steps to set up and run the project:

1. Install **Dart/Flutter SDK** and **Docker**.
2. Activate the Serverpod CLI by running:
   ```bash
   dart pub global activate serverpod_cli
   ```
3. Go to the `demo_server` folder in the terminal and run:
   ```bash
   serverpod generate
   ```
4. Fetch dependencies for all parts of the project:
   ```bash
   dart pub get
   ```
   Run this in `demo_client`, `demo_flutter`, and `demo_server`.
5. Build and start Docker containers:
   ```bash
   docker compose up --build --detach
   ```
6. Start the server by running:
   ```bash
   dart bin/main.dart --apply-migrations
   ```
7. Open an emulator to test the app.

This project is a simple and cost-effective task management system. CTMS helps small businesses improve their productivity and manage tasks more easily.
