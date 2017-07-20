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

/** IdentifiableLanguage. */
public struct IdentifiableLanguage: JSONDecodable, JSONEncodable {

    /// The code for an identifiable language.
    public let language: String

    /// The name of the identifiable language.
    public let name: String

    /**
     Initialize a `IdentifiableLanguage` with member variables.

     - parameter language: The code for an identifiable language.
     - parameter name: The name of the identifiable language.

     - returns: An initialized `IdentifiableLanguage`.
    */
    public init(language: String, name: String) {
        self.language = language
        self.name = name
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `IdentifiableLanguage` model from JSON.
    public init(json: JSON) throws {
        language = try json.getString(at: "language")
        name = try json.getString(at: "name")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `IdentifiableLanguage` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["language"] = language
        json["name"] = name
        return json
    }
}
