import Foundation

public struct Barcode: Identifiable, Hashable, Codable {
    public let id: UUID
//    public let food: Food
    public let payload: String
    public let symbology: BarcodeSymbology
    
    public init(id: UUID, payload: String, symbology: BarcodeSymbology) {
        self.id = id
//        self.food = food
        self.payload = payload
        self.symbology = symbology
    }
}

