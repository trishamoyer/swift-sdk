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

/** **Deprecated**: Summary of the memory usage statistics for this environment. */
public struct MemoryUsage {

    /// **Deprecated**: Number of bytes used in the environment's memory capacity.
    public var usedBytes: Int?

    /// **Deprecated**: Total number of bytes available in the environment's memory capacity.
    public var totalBytes: Int?

    /// **Deprecated**: Amount of memory capacity used, in KB or GB format.
    public var used: String?

    /// **Deprecated**: Total amount of the environment's memory capacity, in KB or GB format.
    public var total: String?

    /// **Deprecated**: Percentage of the environment's memory capacity that is being used.
    public var percentUsed: Double?

    /**
     Initialize a `MemoryUsage` with member variables.

     - parameter usedBytes: **Deprecated**: Number of bytes used in the environment's memory capacity.
     - parameter totalBytes: **Deprecated**: Total number of bytes available in the environment's memory capacity.
     - parameter used: **Deprecated**: Amount of memory capacity used, in KB or GB format.
     - parameter total: **Deprecated**: Total amount of the environment's memory capacity, in KB or GB format.
     - parameter percentUsed: **Deprecated**: Percentage of the environment's memory capacity that is being used.

     - returns: An initialized `MemoryUsage`.
    */
    public init(usedBytes: Int? = nil, totalBytes: Int? = nil, used: String? = nil, total: String? = nil, percentUsed: Double? = nil) {
        self.usedBytes = usedBytes
        self.totalBytes = totalBytes
        self.used = used
        self.total = total
        self.percentUsed = percentUsed
    }
}

extension MemoryUsage: Codable {

    private enum CodingKeys: String, CodingKey {
        case usedBytes = "used_bytes"
        case totalBytes = "total_bytes"
        case used = "used"
        case total = "total"
        case percentUsed = "percent_used"
        static let allValues = [usedBytes, totalBytes, used, total, percentUsed]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        usedBytes = try container.decodeIfPresent(Int.self, forKey: .usedBytes)
        totalBytes = try container.decodeIfPresent(Int.self, forKey: .totalBytes)
        used = try container.decodeIfPresent(String.self, forKey: .used)
        total = try container.decodeIfPresent(String.self, forKey: .total)
        percentUsed = try container.decodeIfPresent(Double.self, forKey: .percentUsed)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(usedBytes, forKey: .usedBytes)
        try container.encodeIfPresent(totalBytes, forKey: .totalBytes)
        try container.encodeIfPresent(used, forKey: .used)
        try container.encodeIfPresent(total, forKey: .total)
        try container.encodeIfPresent(percentUsed, forKey: .percentUsed)
    }

}
