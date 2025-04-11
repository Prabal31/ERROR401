//
//  AddTaskViewController.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-10.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
        timePicker.datePickerMode = .time
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty else {
            showAlert(title: "Missing Info", message: "Please enter both a title and description.")
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: datePicker.date)
        

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: timePicker.date)
        
        print("📦 Saving task with date: \(dateString) and time: \(timeString)")


        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.insertTask(title: title, description: description, date: dateString, time: timeString)

        let alert = UIAlertController(
            title: "✅ Task Saved!",
            
            message: "Your task was added successfully. Tap OK to view it.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.performSegue(withIdentifier: "ViewPage", sender: self)
        })
        present(alert, animated: true)
    }

    @IBAction func BackToHome(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "BackToHome", sender: self)
    }

    @IBAction func ViewPage(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ViewPage", sender: self)
    }

    // MARK: - Helper Alert

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
