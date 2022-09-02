//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Leysan Latypova on 02.09.2022.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func test() {
        database.child("foo").setValue(["something": true])
    }
}
