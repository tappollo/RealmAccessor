//
//  ViewModel.swift
//  RealmAccessor
//
//  Created by Ruoyu Fu on 2018/5/24.
//  Copyright © 2018 Ruoyu Fu. All rights reserved.
//

import UIKit

struct LogEntryVM {
    
    let timestamp: String
    let tintColor: UIColor
    let summary: String
    let content: String
    
    
    init(entry: LogEntry) {
        let logEntryDate = Date(timeIntervalSinceReferenceDate: entry.timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .long
        timestamp = dateFormatter.string(from: logEntryDate)
        tintColor = entry.logType == "error" ? .red : .black
        if entry.content.count > 20 {
            let endIndex =  entry.content.index(entry.content.startIndex, offsetBy: 40)
            summary = entry.content[..<endIndex] + "..."
        } else {
            summary = entry.content
        }
        content = [
            "• Timestamp: \(timestamp)",
            "• logEntryID: \(entry.logEntryID)",
            "• file: \(entry.file)",
            "• function: \(entry.function)",
            "• line: \(entry.line)",
            "• size: \(entry.content.utf8.count) bytes",
            entry.content,
            ].joined(separator: "\n")
    }

}
