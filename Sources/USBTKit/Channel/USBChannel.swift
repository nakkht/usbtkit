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
import Combine

struct USBChannel: Channel {
    
    static let bufferSize = 2048
    
    let id: UInt
    var port: UInt16 = 666
    var hub: USBHub
    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: USBChannel.bufferSize)
    var dataHandler: ((Data) -> Void)?
    
    func open() -> AnyCancellable {
        let stream = self.hub.input.sink(receiveValue: self.received)
        self.hub.connect()
        return stream
    }
    
    func close() {
        self.hub.disconnect()
    }
    
    func write(data: Data) {
        self.hub.write(data: data)
    }
    
    func received(_ stream: Stream, _ event: Stream.Event) {
        guard let stream = stream as? InputStream, event == .hasBytesAvailable else { return }
        var data = Data()
        while stream.hasBytesAvailable {
            let length = stream.read(buffer, maxLength: USBChannel.bufferSize)
            if length > 0 { data.append(buffer, count: length) }
        }
        if !data.isEmpty { dataHandler?(data) }
    }
}
