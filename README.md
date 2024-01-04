<p align="center">
  <img src="VocabGem/Assets.xcassets/AppIcon.appiconset/1024.png" alt="VocabGem App Icon" width="150" height="150">
</p>

# VocabGem

VocabGem is an English vocabulary app that elevates your English vocabulary with Search, listen, learn, and quiz – all in one app. 

## Table of Contents
- [Features](#features)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
  - [Unit Tests](#unit-tests)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Authentication](#authentication)
  - [Search Words](#search-words)
  - [Quiz](#quiz)
- [Known Issues](#known-issues)
- [Improvements](#improvements)
- [Contributing](#contributing)
- [License](#license)

## Features

- **User Authentication:**
- Secure login and registration system using email/password.
- Easy authentication with Google account for a seamless user experience.
- **Word Search:**
- Effortlessly search for words to access comprehensive information.
- **Pronunciation Assistance:**
- Listen to accurate word pronunciations for improved language learning.
- **Interactive Quizzes:**
- Engage in quizzes to practice and reinforce vocabulary knowledge.

### Tech Stack

- **Xcode:** Version 14.3.1
- **Language:** Swift 5.8.1
- **Minimum iOS Version:** 16.4
- **Dependency Manager:** SPM

### Architecture

![Architecture](https://miro.medium.com/v2/resize:fit:566/1*VS4lOMnFpqEAOwTdDsk4mg.jpeg)

In developing GitInsider, I used the MVVM-C (Model-View-ViewModel-Coordinator) design pattern for these key reasons:

- **Clear Separation:** MVVM-C ensures a distinct separation of concerns, simplifying development with isolated layers for UI logic (ViewModel), business logic (Model), and navigation flow (Coordinator).
- **Test-Driven Development:** The pattern's modularity facilitates effective unit testing, enabling me to write comprehensive tests for each layer and ensure the app's stability.
- **Scalability:** MVVM-C offers scalability, allowing the seamless addition of new features and easy maintenance, promoting agility in code evolution.
- **Navigation Control:** The Coordinator element provides centralized navigation control, resulting in a well-organized and efficient navigation structure within the app.

### Unit Tests

All ViewMododels are tested for ensuring the proper functionality of the app.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- Xcode installed
- Have an GitHub Account for OAuth credentials

Also, make sure that these dependencies are added in your project's target:

- [Moya](https://github.com/Moya/Moya): Network abstraction layer written in Swift.
- [Firebase](https://github.com/firebase/firebase-ios-sdk): A comprehensive suite of tools for building scalable and feature-rich apps, including authentication, real-time databases, and more.
- [GoogleSignIn](https://github.com/google/GoogleSignIn-iOS): Enables seamless authentication with Google accounts in your app.
- [JGProgressHUD](https://github.com/JonasGessner/JGProgressHUD): A versatile and customizable progress HUD to provide users with feedback during asynchronous tasks.

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/lochmidth/VocabGem.git
    ```

2. Open the project in Xcode:

    ```bash
    cd VocabGem
    open VocabGem.xcodeproj
    ```
3. Add required dependencies using Swift Package Manager:

   ```bash
   - Moya
   - Firebase
   - GoogleSignIn
   - JGProgressHUD
    ```

6. Build and run the project.

## Usage

###  Authentication

1. Open the app on your simulator or device.
2. Tap on "Sign in with Google" to authorize the app with your Google account, or use email and password for login/register.

---

### Search Words

1. Use the search bar to find English words.
2. Tap on the word you want and find Details about it. This word also will be added to "Recents" for easy access in the next usage.

---

### Quiz

1. Tap "Quiz" on the tab bar to take the quiz.
2. Tap the correct answer button to score. Score will be uploaded to the database so that you can keep your score all the time.

---

## Known Issues
- After the first build and run, presentation of Google Auth takes some time but still works.
- On some simulators, Voice data in spoken Content are missing, you can download any voice data in Settings -> Accessibility -> Spoken Content. Turn on "Speak Selection" and add any voice you want. ( I suggest "Enhanced Daniel")

## Improvemets
- A more pleasent and comfortable UI can be designed. I kept it simple due to short amount of time.
- Localization for other languages can be added to be able to reach more user.
- There is only 10 quiz questions in the database and app loops the same questions after finishing it. However, more questions can be easily added to the database anytime.


## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change. Please make sure to update tests as appropiate.

## License

This project is licensed under the [MIT License](LICENSE).
