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
//    var trashId: String
    var trashCanId: String
    var userIdReportedFull: String
    var dateReportedFull: Date
    var userIdReportedEmpty: String? = nil
    var dateReportedEmpty: Date? = nil
    var type: Int
    var size: Int
}
