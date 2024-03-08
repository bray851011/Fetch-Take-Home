//
//  User.swift
//  Fetch-Take-Home
//
//  Created by 阮柏睿 on 3/7/24.
//

import Foundation


/// Represents an item in a list.
struct Item: Codable {
    /// The unique identifier of the item.
    let id: Int

    /// The identifier of the list to which the item belongs.
    let listId: Int

    /// The name of the item.
    ///
    /// This property is optional because some items may not have a name.
    let name: String?
}
