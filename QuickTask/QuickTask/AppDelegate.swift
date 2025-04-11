import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var db: OpaquePointer?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        openDatabase()
        createTaskTable()
        createUsersTable()
        return true
    }

    // MARK: - Open/Create DB
    func openDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("QuickTask.sqlite")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("❌ Error opening database")
        } else {
            print("✅ Database opened at \(fileURL.path)")
        }
    }

    // MARK: - Create Tables
    func createTaskTable() {
        let query = """
        CREATE TABLE IF NOT EXISTS Tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date TEXT,
            time TEXT
        );
        """
        if sqlite3_exec(db, query, nil, nil, nil) != SQLITE_OK {
            print("❌ Error creating Tasks table: \(String(cString: sqlite3_errmsg(db)!))")
        } else {
            print("✅ Tasks table ready")
        }
    }

    func createUsersTable() {
        let query = """
        CREATE TABLE IF NOT EXISTS Users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstName TEXT,
            lastName TEXT,
            email TEXT UNIQUE,
            phone TEXT,
            password TEXT
        );
        """
        if sqlite3_exec(db, query, nil, nil, nil) != SQLITE_OK {
            print("❌ Error creating Users table: \(String(cString: sqlite3_errmsg(db)!))")
        } else {
            print("✅ Users table ready")
        }
    }

    // MARK: - Task CRUD
    func insertTask(title: String, description: String, date: String, time: String) {
        let query = "INSERT INTO Tasks (title, description, date, time) VALUES (?, ?, ?, ?)"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 3, (date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 4, (time as NSString).utf8String, -1, nil)

            print("📦 Saving task with date: \(date) and time: \(time)")

            if sqlite3_step(stmt) == SQLITE_DONE {
                print("✅ Task inserted")
            } else {
                print("❌ Failed to insert task")
            }
        }
        sqlite3_finalize(stmt)
    }

    func fetchTasks() -> [Task] {
        let query = "SELECT * FROM Tasks"
        var stmt: OpaquePointer?
        var tasks: [Task] = []

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(stmt, 0))
                let title = String(cString: sqlite3_column_text(stmt, 1))
                let description = String(cString: sqlite3_column_text(stmt, 2))
                let date = String(cString: sqlite3_column_text(stmt, 3))
                let time = String(cString: sqlite3_column_text(stmt, 4))

                print("🔹 \(title) | \(description) | \(date) | \(time)")

                tasks.append(Task(id: id, title: title, description: description, date: date, time: time))
            }
        }
        sqlite3_finalize(stmt)
        print("🗃 All Tasks Loaded: \(tasks.count)")
        return tasks
    }

    func updateTask(id: Int, title: String, description: String, date: String, time: String) {
        let query = "UPDATE Tasks SET title = ?, description = ?, date = ?, time = ? WHERE id = ?"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 3, (date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 4, (time as NSString).utf8String, -1, nil)
            sqlite3_bind_int(stmt, 5, Int32(id))

            if sqlite3_step(stmt) == SQLITE_DONE {
                print("✅ Task updated")
            } else {
                print("❌ Failed to update task")
            }
        }
        sqlite3_finalize(stmt)
    }

    // MARK: - User Auth
    func insertUser(first: String, last: String, email: String, phone: String, password: String) -> Bool {
        let query = "INSERT INTO Users (firstName, lastName, email, phone, password) VALUES (?, ?, ?, ?, ?)"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (first as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (last as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 3, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 4, (phone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 5, (password as NSString).utf8String, -1, nil)

            if sqlite3_step(stmt) == SQLITE_DONE {
                print("✅ User signed up")
                sqlite3_finalize(stmt)
                return true
            } else {
                print("❌ Email already exists or failed to insert user")
            }
        }
        sqlite3_finalize(stmt)
        return false
    }

    func validateUser(email: String, password: String) -> Bool {
        let query = "SELECT * FROM Users WHERE email = ? AND password = ?"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (password as NSString).utf8String, -1, nil)

            if sqlite3_step(stmt) == SQLITE_ROW {
                sqlite3_finalize(stmt)
                return true
            }
        }
        sqlite3_finalize(stmt)
        return false
    }
}
