//
//  ListSelectionViewController.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 31/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import UIKit
import Swifter

class ListSelectionViewController: UITableViewController {
    
    var lists: [List]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Swifter.shared().getOwnedLists(for: Constants.Twitter.lukestringer90, count: nil, cursor: nil, success: { json, _, _ in
            self.lists = json.array?.flatMap { object -> List? in
                guard
                    let id = object["id"].integer,
                    let slug = object["slug"].string,
                    let name = object["name"].string
                    else { return nil }
                return List(id: id, slug: slug, name: name)
            }
            self.tableView.reloadData()
        }) { error in
            print(error)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let lists = lists else { return 0 }
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        cell.textLabel?.text = lists![indexPath.row].name
        return cell
    }
    
}
