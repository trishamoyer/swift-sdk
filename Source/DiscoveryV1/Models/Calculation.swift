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

/** Calculation. */
public struct Calculation {

    /// The type of aggregation command used. For example: term, filter, max, min, etc.
    public var type: String?

    /// The field where the aggregation is located in the document.
    public var field: String?

    public var results: [AggregationResult]?

    /// The match the aggregated results queried for.
    public var match: String?

    /// Number of matching results.
    public var matchingResults: Int?

    /// Aggregations returned by the Discovery service.
    public var aggregations: [QueryAggregation]?

    /// Value of the aggregation. (For 'max' and 'min' type).
    public var value: Double?

    /**
     Initialize a `Calculation` with member variables.

     - parameter type: The type of aggregation command used. For example: term, filter, max, min, etc.
     - parameter field: The field where the aggregation is located in the document.
     - parameter results:
     - parameter match: The match the aggregated results queried for.
     - parameter matchingResults: Number of matching results.
     - parameter aggregations: Aggregations returned by the Discovery service.
     - parameter value: Value of the aggregation. (For 'max' and 'min' type).

     - returns: An initialized `Calculation`.
    */
    public init(type: String? = nil, field: String? = nil, results: [AggregationResult]? = nil, match: String? = nil, matchingResults: Int? = nil, aggregations: [QueryAggregation]? = nil, value: Double? = nil) {
        self.type = type
        self.field = field
        self.results = results
        self.match = match
        self.matchingResults = matchingResults
        self.aggregations = aggregations
        self.value = value
    }
}

extension Calculation: Codable {

    private enum CodingKeys: String, CodingKey {
        case value = "value"
        static let allValues = [value]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decodeIfPresent(Double.self, forKey: .value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(value, forKey: .value)
    }

}
