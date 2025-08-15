# curd_assignment

A new Flutter project.

## 📌 Architecture

- This project follows the MVVM (Model–View–ViewModel) architecture pattern to ensure a clean separation of concerns, better scalability, and easier testing.

- Model → Represents the data layer (API responses, local storage models, entities).

- View → The UI layer responsible for rendering data and capturing user interactions.

- ViewModel (Bloc/Cubit) → Handles the business logic and state of the application, acting as the bridge between the View and Model.

The MVVM + Bloc Cubit approach was chosen because:

- It provides a clear flow of data and reactive UI updates.

- Business logic is kept separate from the UI, making the app easier to maintain.

- Bloc Cubit allows streamlined state management with less boilerplate than traditional Bloc, but still follows predictable state flow.

- Built-in support for BlocConsumer, BlocBuilder, and BlocListener makes it easy to listen to and react to state changes.

## 📦 Libraries Used & Why

| Library                      | Purpose                 | Why Used                                                                                                                    |
| ---------------------------- | ----------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **flutter\_bloc**            | State management        | Provides a predictable and testable state management solution. Cubit was chosen for its simplicity and minimal boilerplate. |
| **cached\_network\_image**   | Image caching           | Improves performance by caching images locally and reducing network calls.                                                  |
| **flutter\_secure\_storage** | Secure local storage    | Stores sensitive data (cart items, preferences) securely on the device.                                                     |
| **go\_router**               | Navigation              | Provides declarative, URL-based navigation with support for deep linking.                                                   |
| **fluttertoast**             | Toast messages          | Displays short, non-intrusive feedback to the user.                                                                         |
| **intl**                     | Localization            | Handles multilingual support for different languages.                                                                       |
| **mocktail**                 | Mocking in tests        | Simplifies creating mock classes and functions for unit testing without writing boilerplate mock implementations.           |
| **http**                     | API communication       | Handles REST API requests and responses for server interaction.                                                             |
| **connectivity\_plus**       | Network status checking | Detects changes in network connectivity to handle offline/online states gracefully.                                         |
| **flutter\_screenutil**      | Responsive UI           | Helps adapt UI elements proportionally across different screen sizes and resolutions for consistent design.                 |

                                                                  |

## 🚀 How to Run

use flutter sdk `3.32.7`

 Clone the repository
  
- `git clone [repo_link]`
- `cd curd_assignment`

Install dependencies

- `flutter pub get`

Run the app

- `flutter run`

## Demo

<https://github.com/user-attachments/assets/11c45d9d-2787-47ba-9245-7187df3c9318>
