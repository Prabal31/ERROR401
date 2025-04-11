//
//  SignupViewController.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-10.
//
import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func signupTapped(_ sender: UIButton) {
        guard let fname = firstNameField.text, !fname.isEmpty,
              let lname = lastNameField.text, !lname.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let phone = phoneField.text, !phone.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert("All fields are required")
            return
        }

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let success = appDelegate.insertUser(first: fname, last: lname, email: email, phone: phone, password: password)

        if success {
            print("👤 New user created:")
            print("• Name: \(fname) \(lname)")
            print("• Email: \(email)")
            print("• Phone: \(phone)")
            print("• Password: \(password)")

            let alert = UIAlertController(
                title: "✅ Signup Successful",
                message: "Welcome, \(fname)! Tap OK to go to your tasks.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.performSegue(withIdentifier: "BackToLogin", sender: self) // <- make sure this segue exists
            })
            present(alert, animated: true)
        } else {
            showAlert("❌ Email already exists or signup failed.")
        }
    }

    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @IBAction func BackTomain(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "BackTomain", sender: self)
    }

    @IBAction func BackToLogin(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "BackToLogin", sender: self)
    }

}
