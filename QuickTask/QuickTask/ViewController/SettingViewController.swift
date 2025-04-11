//
//  SettingViewController.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-10.
//
import UIKit
import SQLite3

class SettingViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load user details using the saved email
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail") {
            print("📧 Loaded email from UserDefaults: \(email)")
            loadUserInfo(for: email)
        } else {
            print("❌ No logged-in email found in UserDefaults.")
        }
    }

    func loadUserInfo(for email: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let db = appDelegate.db

        var stmt: OpaquePointer?
        let query = "SELECT firstName, lastName, email, phone FROM Users WHERE email = ?"

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, (email as NSString).utf8String, -1, nil)

            if sqlite3_step(stmt) == SQLITE_ROW {
                let firstName = String(cString: sqlite3_column_text(stmt, 0))
                let lastName = String(cString: sqlite3_column_text(stmt, 1))
                let email = String(cString: sqlite3_column_text(stmt, 2))
                let phone = String(cString: sqlite3_column_text(stmt, 3))

                nameLabel.text = "\(firstName) \(lastName)"
                emailLabel.text = email
                phoneLabel.text = phone

                print("✅ Loaded user info: \(firstName) \(lastName), \(email), \(phone)")
            } else {
                print("❌ No user found with this email in the database.")
            }
        } else {
            print("❌ Failed to prepare statement to fetch user info.")
        }

        sqlite3_finalize(stmt)
    }

    // MARK: - Navigation

    @IBAction func Logout(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "loggedInEmail")
        performSegue(withIdentifier: "Logout", sender: self)
    }

    @IBAction func Backtomain(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Backtomain", sender: self)
    }
}
