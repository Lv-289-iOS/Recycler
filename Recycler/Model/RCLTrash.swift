//
//  RCLTrash.swift
//  Recycler
//
//  Created by Roman Shveda on 3/2/18.
//  Copyright © 2018 softserve.univercity. All rights reserved.
//

import Foundation

struct Trash: Codable, Identifiable {
    var id: String? = nil
    var trashCanId: String
    var userIdReportedFull: String
    var dateReportedFull: Date
    var userIdReportedEmpty: String? = nil
    var dateReportedEmpty: Date? = nil
    
    init(trashCanId: String, userIdReportedFull: String) {
        self.trashCanId = trashCanId
        self.userIdReportedFull = userIdReportedFull
        self.dateReportedFull = Date()
    }
    init() {
        self.trashCanId = ""
        self.userIdReportedFull = ""
        self.dateReportedFull = Date()
    }
}
