//
//  RCLFirestoreEnums.swift
//  Recycler
//
//  Created by Roman Shveda on 3/21/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import Foundation

enum RCLCollectionReference: String {
    case users
    case trash
    case trashCan
}

enum RCLTrashSize: Int {
    case small = 1
    case medium = 2
    case large = 3
    case extraLarge = 4
}

enum RCLTrashType: String {
    case plastic
    case metal
    case organic
    case batteries
    case glass
    case paper
}

enum RCLTrashStatus: String {
    case available
    case taken
    case completed
}

enum RCLUserRole: String {
    case cust
    case empl
}
