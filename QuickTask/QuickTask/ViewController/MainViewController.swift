//
//  MainViewController.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-10.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func Logout(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Logout", sender: self)
    }
    @IBAction func Settings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Settings", sender: self)
    }

}
