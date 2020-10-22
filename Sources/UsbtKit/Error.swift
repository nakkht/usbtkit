//
//  onout
//  Copyright © 2020 neqsoft. All rights reserved.
//  

import Foundation

enum Error: Int, Swift.Error, CustomStringConvertible {
    
    case badDevice = 0
    case connectionRefused = 1
    
    var description: String {
        switch self {
        case .badDevice:
            return "Bad device"
        case .connectionRefused:
            return "Connection refused"
        }
    }
}
