/**
 * Copyright IBM Corporation 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/** Corpora. */
public struct Corpora {

    /// Information about corpora of the custom model. The array is empty if the custom model has no corpora.
    public var corpora: [Corpus]

    /**
     Initialize a `Corpora` with member variables.

     - parameter corpora: Information about corpora of the custom model. The array is empty if the custom model has no corpora.

     - returns: An initialized `Corpora`.
    */
    public init(corpora: [Corpus]) {
        self.corpora = corpora
    }
}

extension Corpora: Codable {

    private enum CodingKeys: String, CodingKey {
        case corpora = "corpora"
        static let allValues = [corpora]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        corpora = try container.decode([Corpus].self, forKey: .corpora)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(corpora, forKey: .corpora)
    }

}
