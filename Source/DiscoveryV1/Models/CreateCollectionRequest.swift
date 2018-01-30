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

/** CreateCollectionRequest. */
public struct CreateCollectionRequest {

    /// The language of the documents stored in the collection, in the form of an ISO 639-1 language code.
    public enum Language: String {
        case en = "en"
        case es = "es"
        case de = "de"
        case ar = "ar"
        case fr = "fr"
        case it = "it"
        case ja = "ja"
        case ko = "ko"
        case ptBr = "pt-br"
    }

    /// The name of the collection to be created.
    public var name: String

    /// A description of the collection.
    public var description: String?

    /// The ID of the configuration in which the collection is to be created.
    public var configurationID: String?

    /// The language of the documents stored in the collection, in the form of an ISO 639-1 language code.
    public var language: String?

    /**
     Initialize a `CreateCollectionRequest` with member variables.

     - parameter name: The name of the collection to be created.
     - parameter description: A description of the collection.
     - parameter configurationID: The ID of the configuration in which the collection is to be created.
     - parameter language: The language of the documents stored in the collection, in the form of an ISO 639-1 language code.

     - returns: An initialized `CreateCollectionRequest`.
    */
    public init(name: String, description: String? = nil, configurationID: String? = nil, language: String? = nil) {
        self.name = name
        self.description = description
        self.configurationID = configurationID
        self.language = language
    }
}

extension CreateCollectionRequest: Codable {

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case configurationID = "configuration_id"
        case language = "language"
        static let allValues = [name, description, configurationID, language]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        configurationID = try container.decodeIfPresent(String.self, forKey: .configurationID)
        language = try container.decodeIfPresent(String.self, forKey: .language)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(configurationID, forKey: .configurationID)
        try container.encodeIfPresent(language, forKey: .language)
    }

}