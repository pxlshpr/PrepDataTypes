#if os(iOS) || os(macOS)
import Vision

@available(iOS 16, macOS 12, *)
public extension VNBarcodeSymbology {
    var serverInt: Int16 {
        switch self {
        case .aztec: return 1
        case .code39: return 2
        case .code39Checksum: return 3
        case .code39FullASCII: return 4
        case .code39FullASCIIChecksum: return 5
        case .code93: return 6
        case .code93i: return 7
        case .code128: return 8
        case .dataMatrix: return 9
        case .ean8: return 10
        case .ean13: return 11
        case .i2of5: return 12
        case .i2of5Checksum: return 13
        case .itf14: return 14
        case .pdf417: return 15
        case .qr: return 16
        case .upce: return 17
        case .codabar: return 18
        case .gs1DataBar: return 19
        case .gs1DataBarExpanded: return 20
        case .gs1DataBarLimited: return 21
        case .microPDF417: return 22
        case .microQR: return 23
        default: return 100
        }
    }
}
#endif
