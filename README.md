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
├── AppDelegate.swift               # App setup and DB initialization
├── SceneDelegate.swift             # Scene lifecycle management
│
├── Models/
│   └── Task.swift                  # Data model for tasks
│
├── Controllers/
│   ├── SignupViewController.swift        # Sign-up screen logic
│   ├── LoginViewController.swift         # Login screen logic
│   ├── MainTaskViewController.swift      # Calendar and task list
│   ├── AddEditTaskViewController.swift   # Add/edit task form
│   └── SettingsViewController.swift      # Profile info + logout
│
├── Views/
│   ├── CalendarCell.swift          # Custom horizontal calendar cell
│   └── TaskCell.swift              # UITableViewCell for tasks
│
├── Database/
│   └── DBHelper.swift              # SQLite logic for users & tasks
│
├── Assets.xcassets/               # Icons and image assets
├── LaunchScreen.storyboard        # Launch screen layout
├── Main.storyboard                # Primary UI layout
└── Info.plist                     # App configuration file
```

---

## 🥪 Getting Started

1. **Clone the repository**
   ```bash
   [git clone https://github.com/yourusername/QuickTask.git]
   ```

2. **Open the project in Xcode**
   ```bash
   open QuickTask/QuickTask.xcodeproj
   ```

3. **Build and run** on a simulator or physical device running iOS 15 or higher.

> ✅ Tested with Xcode 14+ and iOS 15+

---

## 📸 Screenshots *(optional)*

Include screenshots here to showcase:
- 🗕️ The calendar with date-based task filtering
- 📝 The task creation/editing screen
- 👤 The profile settings page

---

## 🤛️ Author

**Prabal Manchanda**  
iOS Developer | Swift Enthusiast | Creator of focused and intuitive mobile experiences  
[[LinkedIn](https://linkedin.com/in/yourusername)](https://www.linkedin.com/in/prabal-manchanda/) • [[Portfolio](https://yourportfolio.com)](https://prabalmanchanda.com/) • [[GitHub](https://github.com/yourusername)](https://github.com/Prabal31)


