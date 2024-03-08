//
//  ViewController.swift
//  Fetch-Take-Home
//
//  Created by 阮柏睿 on 3/7/24.
//

import UIKit

class ViewController: UIViewController {
    
    var itemManager = ItemManager()
    var items: [Item] = [Item]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        itemManager.fetchItem { fetchedItems in
            self.items = fetchedItems
        }
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }


}

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

