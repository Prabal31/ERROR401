# 📱 QuickTask

**QuickTask** is a fast, offline-first task manager app for iOS — designed for simplicity, speed, and clarity. Built with **Swift**, **UIKit**, and **SQLite**, it empowers users to stay organized without relying on internet access.

---

## 🚀 Features

- 👤 **User Authentication** — Sign up, log in, and manage sessions
- 📝 **Task Management** — Create, view, edit, and delete tasks
- 🗕️ **Calendar-Based Filtering** — Easily filter tasks by date using a horizontal calendar
- 📀 **Offline Functionality** — All data is stored locally using SQLite
- ⚙️ **Settings Page** — View profile details and log out

---

## 🧰 Tech Stack

- **Swift + UIKit** — Native iOS development
- **SQLite** — Lightweight local database (via C API)
- **UserDefaults** — Session management
- **Xcode + Storyboards** — UI layout and navigation

---

## 📂 Project Structure

```
QuickTask/
│
├── Assets.xcassets/                  # App icons and color sets
│
├── Base.lproj/
│   ├── LaunchScreen.storyboard       # Launch screen layout
│   └── Main.storyboard               # Primary UI layout
│
├── Images/                           # Screenshot images for README/demo
│   ├── b1.jpg
│   ├── base.jpg
│   ├── home.jpg
│   ├── login.jpg
│   ├── M1.jpg
│   ├── M2.jpg
│   ├── Setting.jpeg
│   └── signup.jpeg
│
├── Model/
│   ├── Task.swift                    # Task model
│   └── User.swift                    # User model
│
├── QuickTask.xcdatamodeld/
│   ├── QuickTask.xcdatamodel         # Core Data model
│   └── .xccurrentversion             # Core Data versioning
│
├── ViewController/
│   ├── AddTaskViewController.swift
│   ├── EditTaskViewController.swift
│   ├── LoginViewController.swift
│   ├── MainTaskViewController.swift
│   ├── MainViewController.swift
│   ├── SettingViewController.swift
│   ├── SignupViewController.swift
│   └── ViewController.swift
│
├── AppDelegate.swift                # App lifecycle and DB setup
├── SceneDelegate.swift              # Scene lifecycle
├── Info.plist                       # App configuration
├── LICENSE                          # MIT License
└── QuickTask.xcodeproj/             # Xcode project file
```

---

## 🥪 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/QuickTask.git

2. **Open the project in Xcode**
   ```bash
   open QuickTask/QuickTask.xcodeproj
   ```

3. **Build and run** on a simulator or physical device running iOS 15 or higher.

> ✅ Tested with Xcode 14+ and iOS 15+

---

## 🤛️ Author

**Prabal Manchanda**  
iOS Developer | Swift Enthusiast | Creator of focused and intuitive mobile experiences  
[[LinkedIn](https://linkedin.com/in/yourusername)](https://www.linkedin.com/in/prabal-manchanda/) • [[Portfolio](https://yourportfolio.com)](https://prabalmanchanda.com/) • [[GitHub](https://github.com/yourusername)](https://github.com/Prabal31)


