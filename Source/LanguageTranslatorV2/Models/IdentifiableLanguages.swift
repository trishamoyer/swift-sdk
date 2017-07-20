/**
 * Copyright IBM Corporation 2017
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
import RestKit

/** IdentifiableLanguages. */
public struct IdentifiableLanguages: JSONDecodable, JSONEncodable {

    /// A list of all languages that the service can identify.
    public let languages: [IdentifiableLanguage]

    /**
     Initialize a `IdentifiableLanguages` with member variables.

     - parameter languages: A list of all languages that the service can identify.

     - returns: An initialized `IdentifiableLanguages`.
    */
    public init(languages: [IdentifiableLanguage]) {
        self.languages = languages
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `IdentifiableLanguages` model from JSON.
    public init(json: JSON) throws {
        languages = try json.decodedArray(at: "languages", type: IdentifiableLanguage.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `IdentifiableLanguages` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["languages"] = languages.map { $0.toJSONObject() }
        return json
    }
}
