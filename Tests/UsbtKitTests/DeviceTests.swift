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
@testable import UsbtKit

class DeviceTests: XCTestCase {
    
    func testPropertyBounds() {
        let minDevice = Device(id: .min, port: .min)
        XCTAssertEqual(.min, minDevice.id)
        XCTAssertEqual(.min, minDevice.port)
        
        let maxDevice = Device(id: .max, port: .max)
        XCTAssertEqual(.max, maxDevice.id)
        XCTAssertEqual(.max, maxDevice.port)
    }
}
