//
//  LoginViewController.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-10.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

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
            performSegue(withIdentifier: "Homepage", sender: self) // 👈 this triggers your segue to home page
        } else {
            showAlert("Invalid email or password")
        }
    }



    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
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
