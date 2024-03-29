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
import USBTKit
import Combine

class ChatViewModel: ObservableObject {

    @Published var messages = [Message]()

    private let channel: USBChannel
    private var outputStream: AnyCancellable?
    private var connection: AnyCancellable?

    init() {
        self.channel = USBChannel(id: 666)
        self.outputStream = self.channel.output.sink(receiveCompletion: self.handle(completion:), receiveValue: self.handleOutput(_:))
    }

    func listen() async {
        guard connection == nil else { return }
        do {
           try self.connection = await self.channel.listen()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @MainActor
    func send(_ message: String) async {
        guard !message.isEmpty, let data = message.data(using: .utf8) else { return }
        messages.append(Message(type: .ping, content: message))
        await self.channel.write(data: data)
    }

    func handleOutput(_ data: Data) {
        guard let response = String(data: data, encoding: .utf8) else {
            print(data.base64EncodedData())
            return
        }
        print(response)
    }

    func handle(completion: Subscribers.Completion<USBTError>) {
        switch completion {
        case .finished:
            print("completion finished")
        case .failure(let error):
            print(error.description)
        }
    }

    deinit {
        self.connection?.cancel()
        self.outputStream?.cancel()
    }
}
