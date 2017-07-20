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

/** The response type for listing existing translation models. */
public struct TranslationModels: JSONDecodable, JSONEncodable {

    /// An array of available models.
    public let models: [TranslationModel]

    /**
     Initialize a `TranslationModels` with member variables.

     - parameter models: An array of available models.

     - returns: An initialized `TranslationModels`.
    */
    public init(models: [TranslationModel]) {
        self.models = models
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `TranslationModels` model from JSON.
    public init(json: JSON) throws {
        models = try json.decodedArray(at: "models", type: TranslationModel.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `TranslationModels` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["models"] = models.map { $0.toJSONObject() }
        return json
    }
}
