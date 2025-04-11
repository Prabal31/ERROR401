//
//  EditTaskViewController.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-10.
//

import UIKit
import SQLite3

class EditTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!

    var existingTask: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        // Set delegates
        titleField.delegate = self
        descField.delegate = self

        // Dismiss keyboard on tap outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Dismiss Keyboard

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Setup UI with Task Data

    func configureUI() {
        guard let task = existingTask else { return }

        titleField.text = task.title
        descField.text = task.description

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: task.date) {
            datePicker.date = date
        }

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        if let time = timeFormatter.date(from: task.time) {
            timePicker.date = time
        }
    }

    // MARK: - Save Task

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let title = titleField.text, !title.isEmpty,
              let desc = descField.text, !desc.isEmpty else {
            showAlert(title: "Error", message: "All fields are required.")
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: datePicker.date)

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: timePicker.date)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        // Delete old task if editing
        if let task = existingTask {
            var stmt: OpaquePointer?
            let query = "DELETE FROM Tasks WHERE id = ?"
            if sqlite3_prepare_v2(appDelegate.db, query, -1, &stmt, nil) == SQLITE_OK {
                sqlite3_bind_int(stmt, 1, Int32(task.id))
                if sqlite3_step(stmt) == SQLITE_DONE {
                    print("🗑 Old task deleted.")
                }
            }
            sqlite3_finalize(stmt)
        }

        // Insert updated task
        appDelegate.insertTask(title: title, description: desc, date: dateString, time: timeString)
        showAlert(title: "Success", message: existingTask != nil ? "Task updated." : "Task added.")
    }

    // MARK: - Alert

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    // MARK: - Navigation

    @IBAction func BackToView(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "BackToView", sender: self)
    }
}
