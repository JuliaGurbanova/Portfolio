## Project Overview

This iOS project is a simple issue tracker application built using SwiftUI based on Apple's Feedback Assistant. It allows users to manage and organize their issues by providing features such as filtering, tagging, and sorting. The project includes several key components:

- **ContentView**: The main view of the application where users can see a list of issues and interact with them. This view includes options for filtering, sorting, and creating new issues.

- **SidebarView**: The sidebar view that displays smart filters and user-defined tags. Users can create, rename, and delete tags, which can be used for organizing issues.

- **DetailView**: The detail view for viewing and editing individual issues. Users can modify the title, description, priority, and tags of an issue.

- **AwardsView**: A view that displays awards earned by users based on their interactions with the app.

## Key Features
- **Issue Management**: Users can create, edit, and delete issues.

- **Filtering**: The app supports filtering issues by status, priority, and tags. Users can also filter issues based on predefined smart filters.

- **Tagging**: Users can create custom tags to categorize and organize issues.

- **Sorting**: Issues can be sorted by date created or date modified, in ascending or descending order, by priority or status.

- **Awards**: Users can earn awards based on their interactions with the app.

## Dependencies
The project uses SwiftUI for the user interface and CoreData for data persistence. Additionally, it includes an `Awards.json` file for defining awards that users can earn, and localization files for English and Russian.
