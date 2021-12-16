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

    public let input: PassthroughSubject<(Stream, Stream.Event), USBTError>
    public let output: PassthroughSubject<(Stream, Stream.Event), USBTError>

    private var socket: Socket?

    private init() {
        self.input = PassthroughSubject<(Stream, Stream.Event), USBTError>()
        self.output = PassthroughSubject<(Stream, Stream.Event), USBTError>()
        self.socket = Socket(EventDelegate(self.input), EventDelegate(self.output))
    }

    func connect() async throws {
        try await self.socket?.connect()
    }

    func write(data: Data) async {
        await self.socket?.write(data: data)
    }

    func disconnect() async {
        await self.socket?.disconnect()
    }

    private func input(_ stream: Stream, event: Stream.Event) {
        self.input.send((stream, event))
    }

    private func output(_ stream: Stream, event: Stream.Event) {
        self.output.send((stream, event))
    }
}
