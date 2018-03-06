//
//  Authentificator.swift
//  testApp
//
//  Created by Ganna Melnyk on 3/1/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import Foundation
import UIKit

class Authentificator {
    func isUser(login: String, pass: String) -> Bool {
        return login == "login" && pass == "pass"
    }
}
