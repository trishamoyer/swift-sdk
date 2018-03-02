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

/** AudioResource. */
public struct AudioResource {

    /// The status of the audio resource: * `ok` indicates that the service has successfully analyzed the audio data. The data can be used to train the custom model. * `being_processed` indicates that the service is still analyzing the audio data. The service cannot accept requests to add new audio resources or to train the custom model until its analysis is complete. * `invalid` indicates that the audio data is not valid for training the custom model (possibly because it has the wrong format or sampling rate, or because it is corrupted). For an archive file, the entire archive is invalid if any of its audio files are invalid.
    public enum Status: String {
        case ok = "ok"
        case beingProcessed = "being_processed"
        case invalid = "invalid"
    }

    /// The total seconds of audio in the audio resource.
    public var duration: Double

    /// The name of the audio resource.
    public var name: String

    /// An `AudioDetails` object that provides detailed information about the audio resource. The object is empty until the service finishes processing the audio.
    public var details: AudioDetails

    /// The status of the audio resource: * `ok` indicates that the service has successfully analyzed the audio data. The data can be used to train the custom model. * `being_processed` indicates that the service is still analyzing the audio data. The service cannot accept requests to add new audio resources or to train the custom model until its analysis is complete. * `invalid` indicates that the audio data is not valid for training the custom model (possibly because it has the wrong format or sampling rate, or because it is corrupted). For an archive file, the entire archive is invalid if any of its audio files are invalid.
    public var status: String

    /**
     Initialize a `AudioResource` with member variables.

     - parameter duration: The total seconds of audio in the audio resource.
     - parameter name: The name of the audio resource.
     - parameter details: An `AudioDetails` object that provides detailed information about the audio resource. The object is empty until the service finishes processing the audio.
     - parameter status: The status of the audio resource: * `ok` indicates that the service has successfully analyzed the audio data. The data can be used to train the custom model. * `being_processed` indicates that the service is still analyzing the audio data. The service cannot accept requests to add new audio resources or to train the custom model until its analysis is complete. * `invalid` indicates that the audio data is not valid for training the custom model (possibly because it has the wrong format or sampling rate, or because it is corrupted). For an archive file, the entire archive is invalid if any of its audio files are invalid.

     - returns: An initialized `AudioResource`.
    */
    public init(duration: Double, name: String, details: AudioDetails, status: String) {
        self.duration = duration
        self.name = name
        self.details = details
        self.status = status
    }
}

extension AudioResource: Codable {

    private enum CodingKeys: String, CodingKey {
        case duration = "duration"
        case name = "name"
        case details = "details"
        case status = "status"
        static let allValues = [duration, name, details, status]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        duration = try container.decode(Double.self, forKey: .duration)
        name = try container.decode(String.self, forKey: .name)
        details = try container.decode(AudioDetails.self, forKey: .details)
        status = try container.decode(String.self, forKey: .status)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(duration, forKey: .duration)
        try container.encode(name, forKey: .name)
        try container.encode(details, forKey: .details)
        try container.encode(status, forKey: .status)
    }

}
