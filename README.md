# Instagram Stories Clone

## Features

- Display a list of stories in a horizontally scrollable view.
- Fetch stories data from a backend API.
- View each story with a cube swipe animation.
- Automatically advance to the next story after a set duration (5 seconds).
- Display a progress bar indicating the timer.
- Riverpod is used for state management.

## Screenshots

## Getting Started

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/toseefkhan403/instagram-stories-clone.git
    cd instagram-stories-clone
    ```

2. Install dependencies:
    ```sh
    flutter pub get
    ```

3. Run the app:
    ```sh
    flutter run
    ```

## Architecture and Design Choices

### State Management

This application uses [Riverpod](https://riverpod.dev/) for state management. Riverpod was chosen because of its simplicity, performance, and compile-time safety. Using Riverpod helps manage the state of the timer and stories data efficiently and ensures that the state updates are predictable and testable.

### Cube Animation

`flutter_carousel_slider` package is used to create a cube swipe animation. This provides a visually appealing transition between stories and enhances the user experience.

### Performance and Scalability

- **Efficient State Management**: By using Riverpod, we ensure that state updates are minimal and efficient. Only the necessary parts of the widget tree are rebuilt when the state changes.
- **Asynchronous Data Fetching**: Stories are fetched asynchronously from a backend API, ensuring that the UI remains responsive.
- **Custom Animations**: Implementing animations like the cube swipe ensures that the transitions are smooth and performant.

### Assumptions

- **Data Structure**: It is assumed that the stories data from the backend API includes fields for `imageUrl` and `title`.
- **Timer Duration**: The timer duration for each story is set to 5 seconds, which can be customized as needed.
