//
// Copyright 2020 Paulius Gudonis
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//  

import Foundation

final class Socket {
    
    static let muxdPath = "/var/run/usbmuxd"
    private var socketHandle: SocketNativeHandle
    
    init() {
        self.socketHandle = socket(AF_UNIX, SOCK_STREAM, 0)
        self.configure(socketHandle)
    }
    
    func configure(_ socketHandle: SocketNativeHandle) {
        var on = 1
        setsockopt(socketHandle, SOL_SOCKET, SO_NOSIGPIPE, &on, socklen_t(MemoryLayout<Int>.size))
        setsockopt(socketHandle, SOL_SOCKET, SO_REUSEADDR, &on, socklen_t(MemoryLayout<Int>.size))
        setsockopt(socketHandle, SOL_SOCKET, SO_REUSEPORT, &on, socklen_t(MemoryLayout<Int>.size))
    }
    
    func connect() {
        var addr = self.address
        _ = withUnsafeMutablePointer(to: &addr) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                Darwin.connect(socketHandle, $0, socklen_t(MemoryLayout.size(ofValue: address)))
            }
        }
    }
    
    func write() {
        
    }
    
    func disconnect() {
        self.socketHandle = -1
    }
    
    var address: sockaddr_un {
        var socketAddr = sockaddr_un()
        socketAddr.sun_family = sa_family_t(AF_UNIX)
        withUnsafeMutablePointer(to: &socketAddr.sun_path.0) { (pointer) in
            Socket.muxdPath.withCString {
                let length = Int(strlen($0))
                strncpy(pointer, $0, length)
            }
        }
        return socketAddr
    }
}
