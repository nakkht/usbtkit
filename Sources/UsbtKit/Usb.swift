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

class Usb {
    
    static let threadName = "usbtkit.usb"
    static let shared = Usb()
    
    private let io = DispatchQueue(label: "usbtkit.usb")
    private var socket: Socket?
    private var thread: Thread?
    private var inputDelegate: StreamDelegate?
    private var outputDelegate: StreamDelegate?
    
    private init() {
        self.inputDelegate = StreamDelegate(self.input)
        self.outputDelegate = StreamDelegate(self.output)
        self.socket = Socket(inputDelegate, outputDelegate)
    }
    
    func connect()  { }
    
    func startThread() {
        self.thread = Thread {
            while(!(self.thread?.isCancelled ?? true)) {
                RunLoop.current.run(mode: .default,
                                    before: Date.distantFuture)
            }
            Thread.exit()
        }
        self.thread?.name = Usb.threadName
        self.thread?.start()
    }
    
    func input(_ stream: Stream, event: Stream.Event) {
        
    }
    
    func output(_ stream: Stream, event: Stream.Event) {
        
    }
}
