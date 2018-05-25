//
//  Model.swift
//  RealmAccessor
//
//  Created by Ruoyu Fu on 2018/5/24.
//  Copyright © 2018 Ruoyu Fu. All rights reserved.
//


import RealmSwift


class LogEntry: Object {

    @objc dynamic var logEntryID: String = UUID().uuidString
    @objc dynamic var timestamp = NSDate().timeIntervalSinceReferenceDate
    @objc dynamic var content: String = ""
    @objc dynamic var logType: String = ""
    @objc dynamic var file: String = ""
    @objc dynamic var function: String = ""
    @objc dynamic var line: Int = 0


    convenience init(_ content: Any, file: String, function: String, line: Int, logType: String = "info") {
        self.init()
        self.content = String(describing: content)
        self.file = file
        self.function = function
        self.line = line
        self.logType = logType
    }

    override static func primaryKey() -> String? {
        return "logEntryID"
    }

}

