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

/** IdentifiedLanguage. */
public struct IdentifiedLanguage: JSONDecodable, JSONEncodable {

    /// The code for an identified language.
    public let language: String

    /// The confidence score for the identified language.
    public let confidence: Double

    /**
     Initialize a `IdentifiedLanguage` with member variables.

     - parameter language: The code for an identified language.
     - parameter confidence: The confidence score for the identified language.

     - returns: An initialized `IdentifiedLanguage`.
    */
    public init(language: String, confidence: Double) {
        self.language = language
        self.confidence = confidence
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `IdentifiedLanguage` model from JSON.
    public init(json: JSON) throws {
        language = try json.getString(at: "language")
        confidence = try json.getDouble(at: "confidence")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `IdentifiedLanguage` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["language"] = language
        json["confidence"] = confidence
        return json
    }
}
