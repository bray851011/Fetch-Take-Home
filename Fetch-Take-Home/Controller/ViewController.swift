//
//  ViewController.swift
//  Fetch-Take-Home
//
//  Created by 阮柏睿 on 3/7/24.
//

import UIKit

/// A view controller that manages the display of items in a table view.
class ViewController: UIViewController {
    
    /// The manager responsible for fetching and managing items.
    var itemManager = ItemManager()
    
    /// An array of items to display in the table view.
    ///
    /// Setting this property triggers a reload of the table view on the main thread.
    var items: [Item] = [Item]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    /// The table view displaying the items.
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure table view
        tableView.dataSource = self
        itemManager.fetchItem { fetchedItems in
            self.items = fetchedItems
        }
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }


}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ItemCell

        let item = items[indexPath.row]
        cell.id.text = String(item.id)
        cell.listId.text = String(item.listId)
        cell.name.text = item.name!

        return cell

    }
}

