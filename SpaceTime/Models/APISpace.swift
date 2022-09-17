//
//  Space.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/16/22.
//

import Foundation

let spaceList = [
    APISpace(name: "test1"),
    APISpace(name: "test2"),
    APISpace(name: "test3"),
    APISpace(name: "test4"),
    APISpace(name: "test5"),
    APISpace(name: "test5"),
    APISpace(name: "test5"),
    APISpace(name: "test5"),
    APISpace(name: "test5"),
]

struct APISpace: Codable {
    var name: String
    var id: String
    
    init(name: String, id: String = UUID().uuidString) {
        self.id = id
        self.name = name
    }
}

struct SpaceRow: Identifiable {
    let id = UUID()
    var left: APISpace
    var right: APISpace?
    
    init(left: APISpace, right: APISpace? = nil) {
        self.left = left
        self.right = right
    }
}
