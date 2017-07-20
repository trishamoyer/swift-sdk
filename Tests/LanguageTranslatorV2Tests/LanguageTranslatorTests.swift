/**
 * Copyright IBM Corporation 2016
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

import XCTest
import Foundation
import LanguageTranslatorV2

class LanguageTranslatorTests: XCTestCase {

    private var languageTranslator: LanguageTranslator!
    private let timeout: TimeInterval = 5.0

    // MARK: - Test Configuration

    /** Set up for each test by instantiating the service. */
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        instantiateLanguageTranslator()
        deleteStaleCustomModels()
    }
    
    static var allTests : [(String, (LanguageTranslatorTests) -> () throws -> Void)] {
        return [
            ("testListModelsAll", testListModelsAll),
            ("testListModelsBySourceLanguage", testListModelsBySourceLanguage),
            ("testListModelsByTargetLanguage", testListModelsByTargetLanguage),
            ("testListModelsDefault", testListModelsDefault),
            ("testCreateDeleteModel", testCreateDeleteModel),
            ("testGetModel", testGetModel),
            ("testTranslateStringWithModelID", testTranslateStringWithModelID),
            ("testTranslateArrayWithModelID", testTranslateArrayWithModelID),
            ("testTranslateStringWithSourceAndTarget", testTranslateStringWithSourceAndTarget),
            ("testTranslateArrayWithSourceAndTarget", testTranslateArrayWithSourceAndTarget),
            ("testGetIdentifiableLanguages", testGetIdentifiableLanguages),
            ("testIdentify", testIdentify),
            ("testGetModelDoesntExist", testGetModelDoesntExist)
        ]
    }

    /** Instantiate Language Translator. */
    func instantiateLanguageTranslator() {
        let username = Credentials.LanguageTranslatorUsername
        let password = Credentials.LanguageTranslatorPassword
        languageTranslator = LanguageTranslator(username: username, password: password)
        languageTranslator.defaultHeaders["X-Watson-Learning-Opt-Out"] = "true"
        languageTranslator.defaultHeaders["X-Watson-Test"] = "true"
    }

    /** Delete any stale custom models that were previously created by unit tests. */
    func deleteStaleCustomModels() {
        let description = "Delete any stale custom models previously created by unit tests."
        let expectation = self.expectation(description: description)
        languageTranslator.listModels(defaultModels: false, failure: failWithError) { modelCollection in
            for model in modelCollection.models {
                if model.baseModelID != "" {
                    self.languageTranslator.deleteModel(modelID: model.modelID) {}
                }
            }
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Fail false negatives. */
    func failWithError(error: Error) {
        XCTFail("Positive test failed with error: \(error)")
    }

    /** Fail false positives. */
    func failWithResult<T>(result: T) {
        XCTFail("Negative test returned a result.")
    }

    /** Wait for expectations. */
    func waitForExpectations() {
        waitForExpectations(timeout: timeout) { error in
            XCTAssertNil(error, "Timeout")
        }
    }

    // MARK: - Positive Tests

    /** Get all models. */
    func testListModelsAll() {
        let description = "Get all models."
        let expectation = self.expectation(description: description)

        languageTranslator.listModels(failure: failWithError) { modelCollection in
            XCTAssertGreaterThan(modelCollection.models.count, 0, "Expected at least 1 model to be returned.")
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Get models, filtered by source language. */
    func testListModelsBySourceLanguage() {
        let description = "Get models, filtered by source language."
        let expectation = self.expectation(description: description)

        languageTranslator.listModels(source: "es", failure: failWithError) { modelCollection in
            XCTAssertGreaterThan(modelCollection.models.count, 0, "Expected at least 1 model to be returned.")
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Get models, filtered by target language. */
    func testListModelsByTargetLanguage() {
        let description = "Get models, filtered by target language."
        let expectation = self.expectation(description: description)

        languageTranslator.listModels(target: "pt", failure: failWithError) { modelCollection in
            XCTAssertGreaterThan(modelCollection.models.count, 0, "Expected at least 1 model to be returned.")
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Get models, filtered by default models. */
    func testListModelsDefault() {
        let description = "Get models, filtered to include only default models."
        let expectation = self.expectation(description: description)

        languageTranslator.listModels(defaultModels: true, failure: failWithError) { modelCollection in
            XCTAssertGreaterThan(modelCollection.models.count, 0, "Expected at least 1 model to be returned.")
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Create and delete a custom model. */
    func testCreateDeleteModel() {
        let creationDescription = "Create a custom language model."
        let creationExpectation = self.expectation(description: creationDescription)
        let deletionDescription = "Delete the custom language model."
        let deletionExpectation = self.expectation(description: deletionDescription)
        
        #if os(iOS)
            let bundle = Bundle(for: type(of: self))
            guard let glossary = bundle.url(forResource: "glossary", withExtension: "tmx") else {
                XCTFail("Unable to read forced glossary.")
                return
            }
        #else
            let glossary = URL(fileURLWithPath: "Tests/LanguageTranslatorV2Tests/glossary.tmx")
        #endif
        
        languageTranslator.createModel(baseModelID: "en-es", name: "custom-english-to-spanish-model",
                                       forcedGlossary: glossary, failure: failWithError)
        {
            model in
            XCTAssertNotEqual(model.modelID, "")
            creationExpectation.fulfill()

            self.languageTranslator.deleteModel(modelID: model.modelID, failure: self.failWithError) {
                deletionExpectation.fulfill()
            }
        }
        waitForExpectations()
    }

    /** Get a model's training status. */
    func testGetModel() {
        let description = "Get a model's training status."
        let expectation = self.expectation(description: description)

        languageTranslator.getModel(modelID: "en-es", failure: failWithError) { monitorTraining in
            XCTAssertEqual(monitorTraining.status, TranslationModel.Status.available)
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Translate a text string, specifying the model by model id. */
    func testTranslateStringWithModelID() {
        let description = "Translate text string, specifying the model by model id."
        let expectation = self.expectation(description: description)

        let text = "Hello"
        let modelID = "en-es-conversational"
        languageTranslator.translate(text: [text], modelID: modelID, failure: failWithError) {
            translation in
            XCTAssertEqual(translation.wordCount, 1)
            XCTAssertEqual(translation.characterCount, 5)
            XCTAssertEqual(translation.translations.count, 1)
            XCTAssertEqual(translation.translations.first?.translation, "Hola")
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Translate a text array, specifying the model by model id. */
    func testTranslateArrayWithModelID() {
        let description = "Translate text array, specifying the model by model id."
        let expectation = self.expectation(description: description)

        let text = ["Hello"]
        let modelID = "en-es-conversational"
        languageTranslator.translate(text: text, modelID: modelID, failure: failWithError) {
            translation in
            XCTAssertEqual(translation.wordCount, 1)
            XCTAssertEqual(translation.characterCount, 5)
            XCTAssertEqual(translation.translations.count, 1)
            XCTAssertEqual(translation.translations.first?.translation, "Hola")
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Translate a text string, specifying the model by source and target language. */
    func testTranslateStringWithSourceAndTarget() {
        let description = "Translate text string, specifying the model by source and target."
        let expectation = self.expectation(description: description)

        languageTranslator.translate(text: ["Hello"], source: "en", target: "es", failure: failWithError) {
            translation in
            XCTAssertEqual(translation.wordCount, 1)
            XCTAssertEqual(translation.characterCount, 5)
            XCTAssertEqual(translation.translations.count, 1)
            XCTAssertEqual(translation.translations.first?.translation, "Hola")
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Translate a text array, specifying the model by source and target language. */
    func testTranslateArrayWithSourceAndTarget() {
        let description = "Translate text array, specifying the model by source and target."
        let expectation = self.expectation(description: description)

        languageTranslator.translate(text: ["Hello"], source: "en", target: "es", failure: failWithError) {
            translation in
            XCTAssertEqual(translation.wordCount, 1)
            XCTAssertEqual(translation.characterCount, 5)
            XCTAssertEqual(translation.translations.count, 1)
            XCTAssertEqual(translation.translations.first?.translation, "Hola")
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Get all identifiable languages. */
    func testGetIdentifiableLanguages() {
        let description = "Get all identifiable languages."
        let expectation = self.expectation(description: description)

        languageTranslator.listIdentifiableLanguages(failure: failWithError) { languageCollection in
            XCTAssertGreaterThan(languageCollection.languages.count, 0, "Expected at least 1 language to be returned.")
            expectation.fulfill()
        }
        waitForExpectations()
    }

    /** Identify the language of a text string. */
    func testIdentify() {
        let description = "Identify the language of a text string."
        let expectation = self.expectation(description: description)

        languageTranslator.identify(text: "Hola", failure: failWithError) { result in
            XCTAssertGreaterThan(result.languages.count, 0, "Expected at least 1 language to be returned.")
            XCTAssertEqual(result.languages.first?.language, "es")
            XCTAssertGreaterThanOrEqual(result.languages.first!.confidence, 0.0)
            XCTAssertLessThanOrEqual(result.languages.first!.confidence, 1.0)
            expectation.fulfill()
        }
        waitForExpectations()
    }

    // MARK: - Negative Tests

    /** Try to get information about a model that doesn't exit. */
    func testGetModelDoesntExist() {
        let description = "Try to get information about a model that doesn't exist."
        let expectation = self.expectation(description: description)

        let failure = { (error: Error) in
            expectation.fulfill()
        }

        languageTranslator.getModel(modelID: "invalid_model_id", failure: failure, success: failWithResult)
        waitForExpectations()
    }
}
