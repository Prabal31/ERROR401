//  MainTaskViewController.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-10.

import UIKit
import SQLite3

class MainTaskViewController: UIViewController,
                              UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout,
                              UITableViewDelegate,
                              UITableViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    var allTasks: [Task] = []
    var filteredTasks: [Task] = []
    var availableDates: [Date] = []
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }

        generateWeekDates()
        selectedIndex = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTasks()
        filterTasks()
    }

    // MARK: - Date Generation

    func generateWeekDates() {
        let calendar = Calendar.current
        let today = Date()
        availableDates = (0..<500).compactMap {
            calendar.date(byAdding: .day, value: $0, to: today)
        }
    }

    // MARK: - Load + Filter Tasks

    func loadTasks() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        allTasks = appDelegate.fetchTasks()

        print("🗃 All Tasks Loaded: \(allTasks.count)")
        for task in allTasks {
            print("🔹 \(task.title) | \(task.date) | \(task.time)")
        }
    }

    func filterTasks() {
        guard !availableDates.isEmpty, selectedIndex < availableDates.count else {
            filteredTasks = []
            tableView.reloadData()
            return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: availableDates[selectedIndex])
        print("📅 Filtering for date: \(selectedDate)")

        filteredTasks = allTasks.filter { $0.date == selectedDate }
        print("✅ Matched Tasks: \(filteredTasks.count)")

        tableView.reloadData()
    }

    // MARK: - Collection View

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableDates.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 6
        return CGSize(width: width, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath)

        let dayLabel = cell.viewWithTag(1) as? UILabel
        let weekdayLabel = cell.viewWithTag(2) as? UILabel

        let date = availableDates[indexPath.item]

        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        dayLabel?.text = dayFormatter.string(from: date)

        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEE"
        weekdayLabel?.text = weekdayFormatter.string(from: date)

        let isSelected = indexPath.item == selectedIndex
        let textColor: UIColor = isSelected ? .white : .black

        dayLabel?.textColor = textColor
        weekdayLabel?.textColor = textColor

        cell.backgroundColor = isSelected ? .black : .clear
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
        filterTasks()
    }

    // MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = filteredTasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        let titleLabel = cell.viewWithTag(1) as? UILabel
        let descLabel = cell.viewWithTag(2) as? UILabel
        let timeLabel = cell.viewWithTag(3) as? UILabel
        let editButton = cell.viewWithTag(4) as? UIButton
        let deleteButton = cell.viewWithTag(5) as? UIButton

        titleLabel?.text = task.title
        descLabel?.text = task.description
        timeLabel?.text = task.time

        editButton?.tag = indexPath.row
        editButton?.addTarget(self, action: #selector(editTask(_:)), for: .touchUpInside)

        deleteButton?.tag = indexPath.row
        deleteButton?.addTarget(self, action: #selector(deleteTask(_:)), for: .touchUpInside)

        return cell
    }

    // MARK: - Edit Task

    @objc func editTask(_ sender: UIButton) {
        let row = sender.tag
        guard row < filteredTasks.count else {
            print("❌ Edit: index out of range")
            return
        }
        let taskToEdit = filteredTasks[row]
        performSegue(withIdentifier: "EditPage", sender: taskToEdit)
    }

    // MARK: - Delete Task

    @objc func deleteTask(_ sender: UIButton) {
        let row = sender.tag
        guard row < filteredTasks.count else {
            print("❌ Delete: index out of range")
            return
        }

        let taskToDelete = filteredTasks[row]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let db = appDelegate.db

        var stmt: OpaquePointer?
        let query = "DELETE FROM Tasks WHERE id = ?"

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_int(stmt, 1, Int32(taskToDelete.id))
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("🗑 Task deleted")
            } else {
                print("❌ Failed to delete task")
            }
        } else {
            print("❌ Prepare statement failed")
        }

        sqlite3_finalize(stmt)
        loadTasks()
        filterTasks()
    }

    // MARK: - Navigation

    @IBAction func AddPage(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddPage", sender: nil)
    }

    @IBAction func BackToHome(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "BackToHome", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditPage",
           let destination = segue.destination as? EditTaskViewController {
            destination.existingTask = sender as? Task
        }
    }
}
