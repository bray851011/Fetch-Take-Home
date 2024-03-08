//
//  UserManager.swift
//  Fetch-Take-Home
//
//  Created by 阮柏睿 on 3/7/24.
//

import Foundation

/// A manager responsible for fetching, parsing, and processing items from a remote server.
struct ItemManager {
    
    /// The URL string for the remote server that provides item data.
    let urlString = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
    
    /// Fetches items from the remote server and calls the completion handler with the fetched items.
    ///
    /// - Parameter completion: A closure that takes an array of `Item` as its argument and returns `Void`.
    func fetchItem(completion: @escaping ([Item]) -> Void) {
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
                    completion(items)
                }
            }
            // Start the task
            task.resume()
        }
    }
    
    /// Parses JSON data into an array of `Item` objects.
    ///
    /// - Parameter itemData: The JSON data to be parsed.
    /// - Returns: An array of `Item` objects parsed from the JSON data.
    func parseJSON(itemData: Data) -> [Item] {
        let decoder = JSONDecoder()
        
        do {
            // Decode JSON data into an array of Item objects
            let decodedData = try decoder.decode([Item].self, from: itemData)
            return decodedData
        } catch {
            print(error)
        }
        return []
    }
    
    
    
    /// Processes the items by grouping them by listId, sorting the groups by listId and then by name, and filter out items where name is blank or null.
    ///
    /// - Parameter items: An array of `Item` objects to be processed.
    /// - Returns: An array of processed `Item` objects.
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
