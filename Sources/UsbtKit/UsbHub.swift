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

final class UsbHub {
    
    public lazy var input = PassthroughSubject<(Stream, Stream.Event), Never>()
    public lazy var output = PassthroughSubject<(Stream, Stream.Event), Never>()
    
    static let threadName = "usbtkit.usb.stream"
    static let shared = UsbHub()
    
    private var socket: Socket?
    private var thread: Thread?
    private var inputDelegate: StreamDelegate?
    private var outputDelegate: StreamDelegate?
    
    private init() {
        self.inputDelegate = StreamDelegate(self.input)
        self.outputDelegate = StreamDelegate(self.output)
        self.thread = Thread(target: self, selector: #selector(configThread), object: nil)
        self.thread?.start()
    }
    
    @objc func configThread() {
        self.thread?.name = UsbHub.threadName
        RunLoop.current.run(mode: .default, before: Date.distantFuture)
        self.socket = Socket(inputDelegate, outputDelegate)
    }
    
    public func connect() {
        self.socket?.connect()
    }
    
    func input(_ stream: Stream, event: Stream.Event) {
        self.input.send((stream, event))
    }
    
    func output(_ stream: Stream, event: Stream.Event) {
        self.output.send((stream, event))
    }
}
