//
//  UserManager.swift
//  Fetch-Take-Home
//
//  Created by 阮柏睿 on 3/7/24.
//

import Foundation

struct ItemManager {
    let urlString = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
    
    func fetchItem(completion: @escaping ([Item]) -> Void) {
//        print("Fetch data from: " + urlString)
        
        var items = [Item]()
        
        // Create a URL
        if let url = URL(string: urlString) {
            
            // Create a URLSession
            let session = URLSession(configuration: .default)
            
            // Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let decodedData = self.parseJSON(itemData: safeData)
                    items = self.getResult(items: decodedData)
//                    print(items)
                    completion(items)
                }
            }
            // Start the task
            task.resume()
        }
    }
    
    func parseJSON(itemData: Data) -> [Item] {
        let decoder = JSONDecoder()
        
        do {
            // In Item array
            let decodedData = try decoder.decode([Item].self, from: itemData)
//            print(decodedData[0])
            return decodedData
        } catch {
            print(error)
        }
        return []
    }
    
    
    func getResult(items: [Item]) -> [Item] {
        var result: [Item] = []
        
        // Group items by listId
        let groupedItems = Dictionary(grouping: items, by: { $0.listId })
        
        // Sort groups by listId
        let sortedGroupedItems = groupedItems.sorted { $0.key < $1.key }

        // Sort items within each group by name
        let sortedItems = sortedGroupedItems.map { (listId, items) in
            return (items.filter { $0.name != nil && !$0.name!.isEmpty }.sorted { $0.name! < $1.name! })
        }

        // Display the sorted and filtered items to the user
        for items in sortedItems {
            for item in items {
                print("\(item.listId), \(item.name!), \(item.id)")
                result.append(item)
            }
        }

        return result
    }
}
