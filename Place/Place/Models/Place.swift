//
//  Place.swift
//  Place
//
//  Created by 이민호 on 8/20/24.
//

import Foundation

struct Place: Hashable, Codable{
    var id: String
    var name: String
    var address: String
    var content: String
    
    init(name: String, address: String = "", content: String = "") {
        self.id = UUID().uuidString
        self.name = name
        self.address = address
        self.content = content
    }
}
