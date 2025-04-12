Sure! Here's a clean, copy-ready **`README.md`** for your **QuickTask** iOS app:

---

```markdown
# 📱 QuickTask

QuickTask is a simple and fast task manager app for iOS. Built with Swift, UIKit, and SQLite, it lets users sign up, log in, and manage daily tasks offline.

---

## ✨ Features

- 👤 User authentication (Sign Up & Login)
- 🗂 Create, view, edit, and delete tasks
- 📅 Filter tasks by date using a horizontal calendar
- 💾 Data stored locally with SQLite
- ⚙️ Settings page to view user profile and logout

---

## 🛠 Technologies Used

- Swift + UIKit
- SQLite (via C API)
- UserDefaults (for session tracking)
- Xcode (Storyboard + Interface Builder)

---

## 📂 Project Structure

```
QuickTask/
├── AppDelegate.swift           # Handles database and app startup
├── Models/
│   └── Task.swift              # Task model class
├── ViewControllers/
│   ├── LoginViewController.swift
│   ├── SignupViewController.swift
│   ├── AddTaskViewController.swift
│   ├── EditTaskViewController.swift
│   ├── MainTaskViewController.swift
│   └── SettingViewController.swift
├── Main.storyboard            # UI & navigation
└── Assets.xcassets            # Images and colors
```

---

## 📸 Screenshots

> Add screenshots here to showcase the app!

---

## 🧪 How to Run

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/QuickTask.git
   ```
2. Open in Xcode:
   ```
   open QuickTask.xcodeproj
   ```
3. Build and run on a simulator or real device (iOS 13+)

---

## 🧱 Database Schema

### Users Table
- id (Int, primary key)
- firstName (Text)
- lastName (Text)
- email (Text, unique)
- phone (Text)
- password (Text)

### Tasks Table
- id (Int, primary key)
- title (Text)
- description (Text)
- date (Text - yyyy-MM-dd)
- time (Text - HH:mm)

---

## ✅ To-Do (Future Enhancements)

- Notifications & reminders for tasks
- Dark mode support
- iCloud sync for task backup
- Profile editing

---

## 🙌 Author

**Prabh Manchanda**  
[LinkedIn](https://linkedin.com/in/prabhmanchanda) | [GitHub](https://github.com/prabhmanchanda)

---

## 📄 License

This project is open source under the [MIT License](LICENSE).
```

---

Just copy and paste that into a `README.md` file in your repo — and you’re good to go. Let me know if you want a version with images or badges too!
