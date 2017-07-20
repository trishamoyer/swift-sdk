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

/** Translation. */
public struct Translation: JSONDecodable, JSONEncodable {

    /// Translation output in UTF-8.
    public let translation: String

    /**
     Initialize a `Translation` with member variables.

     - parameter translation: Translation output in UTF-8.

     - returns: An initialized `Translation`.
    */
    public init(translation: String) {
        self.translation = translation
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `Translation` model from JSON.
    public init(json: JSON) throws {
        translation = try json.getString(at: "translation")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `Translation` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["translation"] = translation
        return json
    }
}
