//
//  onout
//  Copyright © 2020 neqsoft. All rights reserved.
//  

enum MuxPacketType: Int {
    case result = 1
    case connect = 2
    case listen = 3
    case add = 4
    case remove = 5
    case plistPayload = 8
}
