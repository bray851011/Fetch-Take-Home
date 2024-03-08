# Fetch - Take Home Exercise

## Overview

The Take Home Exercise is a project that demonstrates fetching, parsing, and displaying items from a remote server in a table view. It includes a custom table view cell (`ItemCell`) for displaying each item and a manager (`ItemManager`) for fetching and processing the items.

## Installation

To install the project, follow these steps:

1. Clone the project from GitHub.
2. Open the project in Xcode.
3. Build and run the project on a simulator or device.

## Architecture

The project follows the Model-View-Controller (MVC) pattern:

- **Model**:
  - **Item**: Represents an item retrieved from the remote server. It has three properties: `id`, `listId`, and `name`.
  - **ItemManager**: Responsible for fetching items from the remote server (`urlString`), parsing the JSON response, and processing the items. It includes methods for fetching items (`fetchItem(completion:)`), parsing JSON (`parseJSON(itemData:)`), and processing items (`getResult(items:)`).

- **View**:
  - **Main View**: The main view of the application, which includes a table view for displaying the list of items fetched from the server.
  - **ItemCell**: A custom table view cell for displaying each `Item` in the table view. It contains outlets for `listId`, `id`, and `name` labels.

- **Controller**:
  - **View Controller**: Uses `ItemManager` to fetch items and displays them in a table view using `ItemCell`.
