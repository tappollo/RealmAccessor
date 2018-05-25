//
//  AppLogger.swift
//  RealmAccessor
//
//  Created by Ruoyu Fu on 2018/5/25.
//  Copyright © 2018 Ruoyu Fu. All rights reserved.
//

import RealmSwift


class AppLogger {
    
    static let shared = AppLogger()
    
    func info(_ content: Any, file: String = #file, function: String = #function, line: Int = #line) {
        let entry = LogEntry(content, file: file, function: function, line: line, logType: "info")
        addToRealm(withLogEntry: entry)
    }
    
    func error(_ content: Any, file: String = #file, function: String = #function, line: Int = #line) {
        let entry = LogEntry(content, file: file, function: function, line: line, logType: "error")
        addToRealm(withLogEntry: entry)
    }
    
    func addToRealm(withLogEntry logEntry: LogEntry) {
        getRealm
            <^> { (realm:Realm) in
                try realm.write {
                    realm.add(logEntry)
                }}
            |> run(withFailure: { (error) in
                print(error)
            })
        
    }
}
