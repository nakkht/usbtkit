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

actor InputStreamActor {

    private var inputStream: InputStream
    private var inputDelegate: EventDelegate

    init(_ inputStream: InputStream, _ inputDelegate: EventDelegate) {
        self.inputStream = inputStream
        self.inputDelegate = inputDelegate
        self.inputStream.schedule(in: .current, forMode: .default)
        self.inputStream.delegate = self.inputDelegate
        self.inputStream.open()
    }

    func close() async {
        self.inputStream.close()
    }
}
