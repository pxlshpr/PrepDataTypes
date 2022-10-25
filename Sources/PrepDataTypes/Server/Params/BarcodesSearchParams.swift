import Foundation

public struct BarcodesSearchParams: Codable {
    public let payloads: [String]
    
    public init(payloads: [String]) {
        self.payloads = payloads
    }
}
