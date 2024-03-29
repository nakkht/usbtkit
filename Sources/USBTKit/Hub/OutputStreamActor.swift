//
// Copyright 2021 Paulius Gudonis
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

actor OutputStreamActor {

    private var outputStream: OutputStream
    private var outputDelegate: EventDelegate

    init(_ outputStream: OutputStream, _ outputDelegate: EventDelegate) {
        self.outputStream = outputStream
        self.outputDelegate = outputDelegate
        self.outputStream.schedule(in: .current, forMode: .default)
        self.outputStream.delegate = self.outputDelegate
        self.outputStream.open()
    }

    func write(_ dataBufferPointer: UnsafePointer<UInt8>, maxLength: Int) async {
        self.outputStream.write(dataBufferPointer, maxLength: maxLength)
    }

    func close() {
        self.outputStream.close()
    }
}
