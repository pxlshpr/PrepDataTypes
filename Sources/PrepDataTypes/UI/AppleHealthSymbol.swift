#if os(iOS)
import SwiftUI
import ColorSugar

public let HealthBottomColorHex = "fc2e1d"
public let HealthTopColorHex = "fe5fab"

public let HealthTopColor = Color(hex: HealthTopColorHex)
public let HealthBottomColor = Color(hex: HealthBottomColorHex)

public let HealthGradient = LinearGradient(
    colors: [HealthTopColor, HealthBottomColor],
    startPoint: .top,
    endPoint: .bottom
)

public let HealthGradientHorizontal = LinearGradient(
    colors: [HealthTopColor, HealthBottomColor],
    startPoint: .leading,
    endPoint: .trailing
)

public var appleHealthSymbol: some View {
    Image(systemName: "heart.fill")
        .symbolRenderingMode(.palette)
        .foregroundStyle(HealthGradient)
}

public var appleHealthBolt: some View {
    appleHealthSymbol
//    Image(systemName: "bolt.horizontal.fill")
//        .symbolRenderingMode(.palette)
////        .foregroundStyle(HealthGradient)
////        .foregroundStyle(HealthGradientHorizontal)
////        .foregroundStyle(HealthTopColor)
//        .foregroundStyle(.green.gradient)
}
#endif
