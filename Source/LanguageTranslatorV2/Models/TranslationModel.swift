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

/** Response payload for models. */
public struct TranslationModel: JSONDecodable, JSONEncodable {

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

    /// A globally unique string that identifies the underlying model that is used for translation. This string contains all the information about source language, target language, domain, and various other related configurations.
    public let modelID: String

    /// If a model is trained by a user, there might be an optional “name” parameter attached during training to help the user identify the model.
    public let name: String?

    /// Source language in two letter language code. Use the five letter code when clarifying between multiple supported languages. When model_id is used directly, it will override the source-target language combination. Also, when a two letter language code is used, but no suitable default is found, it returns an error.
    public let source: String?

    /// Target language in two letter language code.
    public let target: String?

    /// If this model is a custom model, this returns the base model that it is trained on. For a base model, this response value is empty.
    public let baseModelID: String?

    /// The domain of the translation model.
    public let domain: String?

    /// Whether this model can be used as a base for customization. Customized models are not further customizable, and we don't allow the customization of certain base models.
    public let customizable: Bool?

    /// Whether this model is considered a default model and is used when the source and target languages are specified without the model_id.
    public let defaultModel: Bool?

    /// Returns the Bluemix ID of the instance that created the model, or an empty string if it is a model that is trained by IBM.
    public let owner: String?

    /// Availability of a model.
    public let status: Status?

    /**
     Initialize a `TranslationModel` with member variables.

     - parameter modelID: A globally unique string that identifies the underlying model that is used for translation. This string contains all the information about source language, target language, domain, and various other related configurations.
     - parameter name: If a model is trained by a user, there might be an optional “name” parameter attached during training to help the user identify the model.
     - parameter source: Source language in two letter language code. Use the five letter code when clarifying between multiple supported languages. When model_id is used directly, it will override the source-target language combination. Also, when a two letter language code is used, but no suitable default is found, it returns an error.
     - parameter target: Target language in two letter language code.
     - parameter baseModelID: If this model is a custom model, this returns the base model that it is trained on. For a base model, this response value is empty.
     - parameter domain: The domain of the translation model.
     - parameter customizable: Whether this model can be used as a base for customization. Customized models are not further customizable, and we don't allow the customization of certain base models.
     - parameter defaultModel: Whether this model is considered a default model and is used when the source and target languages are specified without the model_id.
     - parameter owner: Returns the Bluemix ID of the instance that created the model, or an empty string if it is a model that is trained by IBM.
     - parameter status: Availability of a model.

     - returns: An initialized `TranslationModel`.
    */
    public init(modelID: String, name: String? = nil, source: String? = nil, target: String? = nil, baseModelID: String? = nil, domain: String? = nil, customizable: Bool? = nil, defaultModel: Bool? = nil, owner: String? = nil, status: Status? = nil) {
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

    // MARK: JSONDecodable
    /// Used internally to initialize a `TranslationModel` model from JSON.
    public init(json: JSON) throws {
        modelID = try json.getString(at: "model_id")
        name = try? json.getString(at: "name")
        source = try? json.getString(at: "source")
        target = try? json.getString(at: "target")
        baseModelID = try? json.getString(at: "base_model_id")
        domain = try? json.getString(at: "domain")
        customizable = try? json.getBool(at: "customizable")
        defaultModel = try? json.getBool(at: "default_model")
        owner = try? json.getString(at: "owner")
 
        guard let status = Status(rawValue: try json.getString(at: "status")) else {
            let type = type(of: Status.uploading)
            throw JSON.Error.valueNotConvertible(value: json, to: type)
        }
        self.status = status
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `TranslationModel` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["model_id"] = modelID
        if let name = name { json["name"] = name }
        if let source = source { json["source"] = source }
        if let target = target { json["target"] = target }
        if let baseModelID = baseModelID { json["base_model_id"] = baseModelID }
        if let domain = domain { json["domain"] = domain }
        if let customizable = customizable { json["customizable"] = customizable }
        if let defaultModel = defaultModel { json["default_model"] = defaultModel }
        if let owner = owner { json["owner"] = owner }
        if let status = status { json["status"] = status }
        return json
    }
}
