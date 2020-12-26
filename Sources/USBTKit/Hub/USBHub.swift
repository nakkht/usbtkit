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

public final class USBHub {
    
    public lazy var input = PassthroughSubject<(Stream, Stream.Event), Never>()
    public lazy var output = PassthroughSubject<(Stream, Stream.Event), Never>()
    
    static let threadName = "usbtkit.usb.stream"
    static let shared = USBHub()
    
    private var socket: Socket?
    private var thread: Thread?
    private var inputDelegate: EventDelegate?
    private var outputDelegate: EventDelegate?
    
    private init() {
        self.inputDelegate = EventDelegate(self.input)
        self.outputDelegate = EventDelegate(self.output)
        self.thread = Thread(target: self, selector: #selector(configThread), object: nil)
        self.thread?.start()
    }
    
    @objc private func configThread() {
        self.thread?.name = USBHub.threadName
        RunLoop.current.run(mode: .default, before: .distantFuture)
        self.socket = Socket(inputDelegate, outputDelegate)
    }
    
    func connect() {
        self.socket?.connect()
    }
    
    func write(data: Data) {
        self.socket?.write(data: data)
    }
    
    func disconnect() {
        self.socket?.disconnect()
    }
    
    private func input(_ stream: Stream, event: Stream.Event) {
        self.input.send((stream, event))
    }
    
    private func output(_ stream: Stream, event: Stream.Event) {
        self.output.send((stream, event))
    }
}
