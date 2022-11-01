import Foundation

public struct Barcode: Identifiable, Hashable, Codable {
    public let id: UUID
    public let food: Food
    public let payload: String
    public let symbology: BarcodeSymbology
}

