//
//  AppDelegate.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-09.
//
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
        return true
    }

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
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("❌ Error creating table: \(errmsg)")
        } else {
            print("✅ Task table created")
        }
    }

    func insertTask(title: String, description: String, date: String, time: String) {
        var stmt: OpaquePointer?
        let query = "INSERT INTO Tasks (title, description, date, time) VALUES (?, ?, ?, ?)"

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 3, (date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 4, (time as NSString).utf8String, -1, nil)

            if sqlite3_step(stmt) == SQLITE_DONE {
                print("✅ Task inserted")
            } else {
                print("❌ Failed to insert task")
            }
        } else {
            print("❌ Prepare insert statement failed")
        }
        sqlite3_finalize(stmt)
    }

    func fetchTasks() -> [Task] {
        var stmt: OpaquePointer?
        let query = "SELECT * FROM Tasks"
        var results: [Task] = []

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(stmt, 0))
                let title = String(cString: sqlite3_column_text(stmt, 1))
                let description = String(cString: sqlite3_column_text(stmt, 2))
                let date = String(cString: sqlite3_column_text(stmt, 3))
                let time = String(cString: sqlite3_column_text(stmt, 4))

                let task = Task(id: id, title: title, description: description, date: date, time: time)
                results.append(task)
            }
        } else {
            print("❌ Prepare fetch statement failed")
        }
        sqlite3_finalize(stmt)
        return results
    }
}
