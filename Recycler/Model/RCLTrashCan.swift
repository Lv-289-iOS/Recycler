//
//  RCLTrashCan.swift
//  Recycler
//
//  Created by Roman Shveda on 3/2/18.
//  Copyright © 2018 softserve.univercity. All rights reserved.
//

import Foundation

struct TrashCan: Identifiable {
    var id: String?
    var trashId: String
    var userId: String
    var address: String
    var isFull: Bool
    var type: Int
    var size: Int
}
