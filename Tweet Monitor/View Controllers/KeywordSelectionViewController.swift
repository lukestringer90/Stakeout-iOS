//
//  SearchStringsViewController.swift
//  Tweet Monitor
//
//  Created by Luke Stringer on 31/03/2018.
//  Copyright © 2018 Luke Stringer. All rights reserved.
//

import UIKit

class KeywordSelectionViewController: UITableViewController {
    
    var keywords = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Keyword", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let done = UIAlertAction(title: "Done", style: .default) { action in
            guard let text = alert.textFields?.first?.text else { return }
            self.keywords.append(text)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(done)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordCell")!
        cell.textLabel?.text = keywords[indexPath.row]
        return cell
    }
    
}
