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
            print("⚠️ Title or Description is empty")
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: datePicker.date)

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: timePicker.date)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.insertTask(title: title, description: description, date: dateString, time: timeString)

        navigationController?.popViewController(animated: true)
    }

    @IBAction func BackToHome(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "BackToHome", sender: self)
    }
}
