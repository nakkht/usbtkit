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
    
    static let shared = USBHub()
    
    public lazy var input = PassthroughSubject<(Stream, Stream.Event), Never>()
    public lazy var output = PassthroughSubject<(Stream, Stream.Event), Never>()
    
    private var socket: Socket?
    private var queue: DispatchQueue
    private var inputDelegate: EventDelegate?
    private var outputDelegate: EventDelegate?
    
    private init() {
        self.queue = DispatchQueue(label: "usbtkit.usb.stream")
        self.inputDelegate = EventDelegate(self.input)
        self.outputDelegate = EventDelegate(self.output)
        self.socket = Socket(inputDelegate, outputDelegate)
    }
    
    func connect() {
        queue.async {
            self.socket?.connect()
        }
    }
    
    func write(data: Data) {
        queue.async {
            self.socket?.write(data: data)
        }
    }
    
    func disconnect() {
        queue.async {
            self.socket?.disconnect()
        }
    }
    
    private func input(_ stream: Stream, event: Stream.Event) {
        queue.async {
            self.input.send((stream, event))
        }
    }
    
    private func output(_ stream: Stream, event: Stream.Event) {
        queue.async {
            self.output.send((stream, event))
        }
    }
}
