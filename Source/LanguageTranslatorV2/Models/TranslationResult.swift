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

/** TranslationResult. */
public struct TranslationResult: JSONDecodable, JSONEncodable {

    /// Number of words of the complete input text.
    public let wordCount: Int

    /// Number of characters of the complete input text.
    public let characterCount: Int

    /// List of translation output in UTF-8, corresponding to the list of input text.
    public let translations: [Translation]

    /**
     Initialize a `TranslationResult` with member variables.

     - parameter wordCount: Number of words of the complete input text.
     - parameter characterCount: Number of characters of the complete input text.
     - parameter translations: List of translation output in UTF-8, corresponding to the list of input text.

     - returns: An initialized `TranslationResult`.
    */
    public init(wordCount: Int, characterCount: Int, translations: [Translation]) {
        self.wordCount = wordCount
        self.characterCount = characterCount
        self.translations = translations
    }

    // MARK: JSONDecodable
    /// Used internally to initialize a `TranslationResult` model from JSON.
    public init(json: JSON) throws {
        wordCount = try json.getInt(at: "word_count")
        characterCount = try json.getInt(at: "character_count")
        translations = try json.decodedArray(at: "translations", type: Translation.self)
    }

    // MARK: JSONEncodable
    /// Used internally to serialize a `TranslationResult` model to JSON.
    public func toJSONObject() -> Any {
        var json = [String: Any]()
        json["word_count"] = wordCount
        json["character_count"] = characterCount
        json["translations"] = translations.map { $0.toJSONObject() }
        return json
    }
}
