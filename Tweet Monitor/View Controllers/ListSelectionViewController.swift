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
    var selectedList: List?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLists(for: Constants.Twitter.lukestringer90)
    }
}

// MARK: Twitter
extension ListSelectionViewController {
    
    func getLists(for user: UserTag) {
        Swifter.shared().getOwnedLists(for: user, count: nil, cursor: nil, success: { json, _, _ in
            self.lists = json.array?.compactMap { object -> List? in
                guard
                    let id = object["id"].integer,
                    let slug = object["slug"].string,
                    let name = object["name"].string,
                    let ownerScreenName = object["user"].object?["screen_name"]?.string
                    else { return nil }
                return List(id: id, slug: slug, name: name, ownerScreenName: ownerScreenName)
            }
            self.tableView.reloadSections([0], with: .automatic)
        }) { error in
            print(error)
        }
    }
}

// MARK: UITableViewController
extension ListSelectionViewController {
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = lists?[indexPath.row] else { return }
        selectedList = list
        
        if let (slug, screenName) = list.listTag.slugAndOwnerScreenName() {
            print("\(slug), \(screenName)")
        }
    }
    
}
