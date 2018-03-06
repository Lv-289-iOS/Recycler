//
//  RCLTrash.swift
//  Recycler
//
//  Created by Roman Shveda on 3/2/18.
//  Copyright © 2018 softserve.univercity. All rights reserved.
//

import Foundation

struct Trash: Identifiable {
    var id: String? = nil
    var trashCanId: String
    var userIdReportedFull: String? = nil
    var dateReportedFull: Date? = nil
    var userIdReportedEmpty: String? = nil
    var dateReportedEmpty: Date? = nil
    var type: String
    var size: String
    
    init(trashCanId: String, type: String, size: String) {
        self.trashCanId = trashCanId
        self.type = type
        self.size = size
    }
}
