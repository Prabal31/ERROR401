//
//  Task.swift
//  QuickTask
//
//  Created by Prabh Manchanda on 2025-04-09.
//

class Task {
    var id: Int
    var title: String
    var description: String
    var date: String
    var time: String

    init(id: Int, title: String, description: String, date: String, time: String) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.time = time
    }
}
