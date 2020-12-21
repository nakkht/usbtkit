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

import XCTest
@testable import USBTKit

class DeviceTests: XCTestCase {
    
    func testDefaultValues() {
        let id = UInt.max
        let device = Device(id: id)
        
        XCTAssertEqual(UsbHub.defaultPort, device.port)
        XCTAssertEqual(id, device.id)
    }
    
    func testPortValues() {
        let port = UInt16.min
        let id = UInt.min
        let device = Device(id: id, port: port)
        
        XCTAssertEqual(port, device.port)
        XCTAssertEqual(id, device.id)
    }
}
