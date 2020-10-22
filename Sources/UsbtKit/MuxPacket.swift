//
//  onout
//  Copyright © 2020 neqsoft. All rights reserved.
//  

import Foundation

struct MuxPacket {
    
    private static let maxPayloadSize = UINT32_MAX - (UInt32(MemoryLayout<MuxPacket>.size))
    
    var `protocol`: MuxPacketType
    var type: MuxPacketType
    var tag: UInt32
    var data: Data
    
    init?(protocol: MuxPacketType, type: MuxPacketType, tag: UInt32, data: Data) {
        guard data.count <= MuxPacket.maxPayloadSize else { return nil }
        self.protocol = `protocol`
        self.type = type
        self.tag = tag
        self.data = data
    }
    
    var size: UInt32 {
        UInt32(MemoryLayout<MuxPacket>.size) + UInt32(self.data.count)
    }
}
