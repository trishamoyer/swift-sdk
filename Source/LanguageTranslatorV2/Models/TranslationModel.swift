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

/** Response payload for models. */
public struct TranslationModel {

    /// Availability of a model.
    public enum Status: String {
        case uploading = "uploading"
        case uploaded = "uploaded"
        case dispatching = "dispatching"
        case queued = "queued"
        case training = "training"
        case trained = "trained"
        case publishing = "publishing"
        case available = "available"
        case deleted = "deleted"
        case error = "error"
    }

    /// A globally unique string that identifies the underlying model that is used for translation.
    public var modelID: String

    /// Optional name that can be specified when the model is created.
    public var name: String?

    /// Translation source language code.
    public var source: String?

    /// Translation target language code.
    public var target: String?

    /// Model ID of the base model that was used to customize the model. If the model is not a custom model, this will be an empty string.
    public var baseModelID: String?

    /// The domain of the translation model.
    public var domain: String?

    /// Whether this model can be used as a base for customization. Customized models are not further customizable, and some base models are not customizable.
    public var customizable: Bool?

    /// Whether or not the model is a default model. A default model is the model for a given language pair that will be used when that language pair is specified in the source and target parameters.
    public var defaultModel: Bool?

    /// Either an empty string, indicating the model is not a custom model, or the ID of the service instance that created the model.
    public var owner: String?

    /// Availability of a model.
    public var status: String?

    /**
     Initialize a `TranslationModel` with member variables.

     - parameter modelID: A globally unique string that identifies the underlying model that is used for translation.
     - parameter name: Optional name that can be specified when the model is created.
     - parameter source: Translation source language code.
     - parameter target: Translation target language code.
     - parameter baseModelID: Model ID of the base model that was used to customize the model. If the model is not a custom model, this will be an empty string.
     - parameter domain: The domain of the translation model.
     - parameter customizable: Whether this model can be used as a base for customization. Customized models are not further customizable, and some base models are not customizable.
     - parameter defaultModel: Whether or not the model is a default model. A default model is the model for a given language pair that will be used when that language pair is specified in the source and target parameters.
     - parameter owner: Either an empty string, indicating the model is not a custom model, or the ID of the service instance that created the model.
     - parameter status: Availability of a model.

     - returns: An initialized `TranslationModel`.
    */
    public init(modelID: String, name: String? = nil, source: String? = nil, target: String? = nil, baseModelID: String? = nil, domain: String? = nil, customizable: Bool? = nil, defaultModel: Bool? = nil, owner: String? = nil, status: String? = nil) {
        self.modelID = modelID
        self.name = name
        self.source = source
        self.target = target
        self.baseModelID = baseModelID
        self.domain = domain
        self.customizable = customizable
        self.defaultModel = defaultModel
        self.owner = owner
        self.status = status
    }
}

extension TranslationModel: Codable {

    private enum CodingKeys: String, CodingKey {
        case modelID = "model_id"
        case name = "name"
        case source = "source"
        case target = "target"
        case baseModelID = "base_model_id"
        case domain = "domain"
        case customizable = "customizable"
        case defaultModel = "default_model"
        case owner = "owner"
        case status = "status"
        static let allValues = [modelID, name, source, target, baseModelID, domain, customizable, defaultModel, owner, status]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        modelID = try container.decode(String.self, forKey: .modelID)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        target = try container.decodeIfPresent(String.self, forKey: .target)
        baseModelID = try container.decodeIfPresent(String.self, forKey: .baseModelID)
        domain = try container.decodeIfPresent(String.self, forKey: .domain)
        customizable = try container.decodeIfPresent(Bool.self, forKey: .customizable)
        defaultModel = try container.decodeIfPresent(Bool.self, forKey: .defaultModel)
        owner = try container.decodeIfPresent(String.self, forKey: .owner)
        status = try container.decodeIfPresent(String.self, forKey: .status)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(modelID, forKey: .modelID)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(target, forKey: .target)
        try container.encodeIfPresent(baseModelID, forKey: .baseModelID)
        try container.encodeIfPresent(domain, forKey: .domain)
        try container.encodeIfPresent(customizable, forKey: .customizable)
        try container.encodeIfPresent(defaultModel, forKey: .defaultModel)
        try container.encodeIfPresent(owner, forKey: .owner)
        try container.encodeIfPresent(status, forKey: .status)
    }

}
