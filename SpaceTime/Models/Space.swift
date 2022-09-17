//
//  Space.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/16/22.
//

import Foundation

let spaceList = [
    Space(name: "test1"),
    Space(name: "test2"),
    Space(name: "test3"),
    Space(name: "test4"),
    Space(name: "test5"),
    Space(name: "test5"),
    Space(name: "test5"),
    Space(name: "test5"),
    Space(name: "test5"),
]

struct Space: Codable {
    var name: String
    var id: String
    
    init(name: String, id: String = UUID().uuidString) {
        self.id = id
        self.name = name
    }
}

struct SpaceRow: Identifiable {
    let id = UUID()
    var left: Space
    var right: Space?
    
    init(left: Space, right: Space? = nil) {
        self.left = left
        self.right = right
    }
}
