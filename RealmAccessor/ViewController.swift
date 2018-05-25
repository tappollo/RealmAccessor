//
//  ViewController.swift
//  RealmAccessor
//
//  Created by Ruoyu Fu on 2018/5/23.
//  Copyright © 2018 Ruoyu Fu. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UITableViewController {

    var logEntrys:[LogEntryVM]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRealm                                    // get a Realm in a dedicated background thread */
            <^> { $0.objects(LogEntry.self) }       // map: realm to Results of Model */
            <^> Array.init                          // map: Results of Model to Array of Model */
            <^> { $0.map(LogEntryVM.init) }         // map: Array of Model to Array of ViewModel */
            >>- ThreadRunner.main.async             // flatMap: with the line the underline thread is swiched to the main thread */
            |> run(withSuccess: {                   // pipe: actually executing the async function */
                self.logEntrys = $0
                self.tableView.reloadData()
            })
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = logEntrys?[indexPath.row].summary
        cell.textLabel?.textColor = logEntrys?[indexPath.row].tintColor
        cell.detailTextLabel?.text = logEntrys?[indexPath.row].timestamp
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logEntrys?.count ?? 0
    }
    
}

