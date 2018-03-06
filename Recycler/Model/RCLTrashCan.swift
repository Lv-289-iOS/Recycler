//
//  RCLTrashCan.swift
//  Recycler
//
//  Created by Roman Shveda on 3/2/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import Foundation

struct TrashCan: Identifiable {
    var id: String?
    var trashId: String
    var userId: String
    var address: String
    var isFull: Bool = false
    var type: String
    var size: String
    
    init(id: String, trashId: String, userId: String, address: String, type: String, size: String) {
        self.id = id
        self.trashId = trashId
        self.userId = userId
        self.address = address
        self.type = type
        self.size = size
    }
}
