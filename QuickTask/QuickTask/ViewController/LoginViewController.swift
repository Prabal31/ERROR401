//
//  LoginViewController.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-10.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegates
        emailField.delegate = self
        passwordField.delegate = self

        // Add tap gesture to dismiss keyboard
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

    // MARK: - Login Action

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert("Email and password are required")
            return
        }

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let isValid = appDelegate.validateUser(email: email, password: password)

        if isValid {
            UserDefaults.standard.set(email, forKey: "loggedInEmail")
            performSegue(withIdentifier: "Homepage", sender: self)
        } else {
            showAlert("Invalid email or password")
        }
    }

    // MARK: - Alert

    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Navigation

    @IBAction func BackToSignUp(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "BackToSignUp", sender: self)
    }

    @IBAction func Homepage(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Homepage", sender: self)
    }

    @IBAction func main(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "main", sender: self)
    }
}
