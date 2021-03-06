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

/** UpdateSynonym. */
public struct UpdateSynonym {

    /// The text of the synonym.
    public var synonym: String?

    /**
     Initialize a `UpdateSynonym` with member variables.

     - parameter synonym: The text of the synonym.

     - returns: An initialized `UpdateSynonym`.
    */
    public init(synonym: String? = nil) {
        self.synonym = synonym
    }
}

extension UpdateSynonym: Codable {

    private enum CodingKeys: String, CodingKey {
        case synonym = "synonym"
        static let allValues = [synonym]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        synonym = try container.decodeIfPresent(String.self, forKey: .synonym)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(synonym, forKey: .synonym)
    }

}
