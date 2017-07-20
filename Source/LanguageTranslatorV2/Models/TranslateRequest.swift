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

/** TranslateRequest. */
public struct TranslateRequest: JSONDecodable, JSONEncodable {

    /// Input text in UTF-8 encoding. It is a list so that multiple sentences/paragraphs can be submitted. Also accept a single string, instead of an array, as valid input.
    public let text: [String]

    /// The unique model_id of the translation model being used to translate text. The model_id inherently specifies source language, target language, and domain. If the model_id is specified, there is no need for the source and target parameters and the values are ignored.
    public let modelID: String?

    /// Used in combination with target as an alternative way to select the model for translation. When target and source are set, and model_id is not set, the system chooses a default model with the right language pair to translate (usually the model based on the news domain).
    public let source: String?

    /// Used in combination with source as an alternative way to select the model for translation. When target and source are set, and model_id is not set, the system chooses a default model with the right language pair to translate (usually the model based on the news domain).
    public let target: String?

    /**
     Initialize a `TranslateRequest` with member variables.

     - parameter text: Input text in UTF-8 encoding. It is a list so that multiple sentences/paragraphs can be submitted. Also accept a single string, instead of an array, as valid input.
     - parameter modelID: The unique model_id of the translation model being used to translate text. The model_id inherently specifies source language, target language, and domain. If the model_id is specified, there is no need for the source and target parameters and the values are ignored.
     - parameter source: Used in combination with target as an alternative way to select the model for translation. When target and source are set, and model_id is not set, the system chooses a default model with the right language pair to translate (usually the model based on the news domain).
     - parameter target: Used in combination with source as an alternative way to select the model for translation. When target and source are set, and model_id is not set, the system chooses a default model with the right language pair to translate (usually the model based on the news domain).

     - returns: An initialized `TranslateRequest`.
    */
    public init(text: [String], modelID: String? = nil, source: String? = nil, target: String? = nil) {
        self.text = text
        self.modelID = modelID
        self.source = source
        self.target = target
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `TranslateRequest` model from JSON.
    public init(json: JSON) throws {
        text = try json.decodedArray(at: "text", type: String.self)
        modelID = try? json.getString(at: "model_id")
        source = try? json.getString(at: "source")
        target = try? json.getString(at: "target")
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `TranslateRequest` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["text"] = text
        if let modelID = modelID { json["model_id"] = modelID }
        if let source = source { json["source"] = source }
        if let target = target { json["target"] = target }
        return json
    }
}
