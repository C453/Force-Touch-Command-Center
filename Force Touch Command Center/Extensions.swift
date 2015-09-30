//
//  Extensions.swift
//  Force Touch Command Center
//
//  Created by Case Wright on 9/30/15.
//  Copyright © 2015 C453. All rights reserved.
//

import Foundation

//For convinence
extension Int {
    func toBool () ->Bool? {
        switch self {
        case 0:
            return false
        case 1:
            return true
        default:
            return nil
        }
    }
}

extension Bool {
    func toInt () ->Int? {
        switch self {
        case false:
            return 0
        case true:
            return 1
        }
    }
}
