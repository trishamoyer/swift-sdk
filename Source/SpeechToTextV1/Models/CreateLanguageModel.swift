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

/** CreateLanguageModel. */
public struct CreateLanguageModel {

    /// A user-defined name for the new custom language model. Use a name that is unique among all custom language models that you own. Use a localized name that matches the language of the custom model. Use a name that describes the domain of the custom model, such as `Medical custom model` or `Legal custom model`.
    public var name: String

    /// The name of the base language model that is to be customized by the new custom language model. The new custom model can be used only with the base model that it customizes. To determine whether a base model supports language model customization, request information about the base model and check that the attribute `custom_language_model` is set to `true`, or refer to [Language support for customization](https://console.bluemix.net/docs/services/speech-to-text/custom.html#languageSupport).
    public var baseModelName: String

    /// The dialect of the specified language that is to be used with the custom language model. The parameter is meaningful only for Spanish models, for which the service creates a custom language model that is suited for speech in one of the following dialects: * `es-ES` for Castilian Spanish (the default) * `es-LA` for Latin American Spanish * `es-US` for North American (Mexican) Spanish   A specified dialect must be valid for the base model. By default, the dialect matches the language of the base model; for example, `en-US` for either of the US English language models.
    public var dialect: String?

    /// A description of the new custom language model. Use a localized description that matches the language of the custom model.
    public var description: String?

    /**
     Initialize a `CreateLanguageModel` with member variables.

     - parameter name: A user-defined name for the new custom language model. Use a name that is unique among all custom language models that you own. Use a localized name that matches the language of the custom model. Use a name that describes the domain of the custom model, such as `Medical custom model` or `Legal custom model`.
     - parameter baseModelName: The name of the base language model that is to be customized by the new custom language model. The new custom model can be used only with the base model that it customizes. To determine whether a base model supports language model customization, request information about the base model and check that the attribute `custom_language_model` is set to `true`, or refer to [Language support for customization](https://console.bluemix.net/docs/services/speech-to-text/custom.html#languageSupport).
     - parameter dialect: The dialect of the specified language that is to be used with the custom language model. The parameter is meaningful only for Spanish models, for which the service creates a custom language model that is suited for speech in one of the following dialects: * `es-ES` for Castilian Spanish (the default) * `es-LA` for Latin American Spanish * `es-US` for North American (Mexican) Spanish   A specified dialect must be valid for the base model. By default, the dialect matches the language of the base model; for example, `en-US` for either of the US English language models.
     - parameter description: A description of the new custom language model. Use a localized description that matches the language of the custom model.

     - returns: An initialized `CreateLanguageModel`.
    */
    public init(name: String, baseModelName: String, dialect: String? = nil, description: String? = nil) {
        self.name = name
        self.baseModelName = baseModelName
        self.dialect = dialect
        self.description = description
    }
}

extension CreateLanguageModel: Codable {

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case baseModelName = "base_model_name"
        case dialect = "dialect"
        case description = "description"
        static let allValues = [name, baseModelName, dialect, description]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        baseModelName = try container.decode(String.self, forKey: .baseModelName)
        dialect = try container.decodeIfPresent(String.self, forKey: .dialect)
        description = try container.decodeIfPresent(String.self, forKey: .description)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(baseModelName, forKey: .baseModelName)
        try container.encodeIfPresent(dialect, forKey: .dialect)
        try container.encodeIfPresent(description, forKey: .description)
    }

}
