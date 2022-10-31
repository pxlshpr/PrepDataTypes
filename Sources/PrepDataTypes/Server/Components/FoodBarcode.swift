import Foundation

public struct FoodBarcode: Codable, Hashable {
    public var payload: String
    public var symbology: BarcodeSymbology
    
    public init(payload: String, symbology: BarcodeSymbology) {
        self.payload = payload
        self.symbology = symbology
    }
}

public extension FoodBarcode {
    func validate() throws {
        /// ** Note: Barcode validation is expected to be carried out on device **
        /// This decision was made in order to avoid having to add `yeahdongcn/RSBarcodes_Swift`
        /// which might need some tweaking to work on Linux
        /// in addition to being bloated with having a lot more than simply validating barcodes.
    }
}
