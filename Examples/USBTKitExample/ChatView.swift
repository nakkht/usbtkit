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

import SwiftUI

struct ChatView: View {

    @State private var textInput = ""

    @ObservedObject var viewModel: MessageViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.messages, id: \.self) {
                        MessageView(message: $0)
                            .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            Spacer()
            HStack {
                TextField("Enter a message", text: $textInput)
                Button("Send") {
                    self.viewModel.send(textInput)
                    self.textInput = ""
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MessageView: View {

    let message: Message

    var body: some View {
        if message.type == .ping {
            HStack {
                Spacer()
                self.textView
            }
        } else {
            HStack {
                self.textView
                Spacer()
            }
        }
    }

    var textView: some View {
        Text(message.content)
            .font(.subheadline)
            .foregroundColor(.white)
            .padding(10)
            .background(message.type == .ping ? Color.blue : Color.purple)
            .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: MessageViewModel())
    }
}
