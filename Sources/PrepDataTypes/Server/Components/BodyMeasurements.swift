import Foundation

public struct BodyMeasurements: Codable, Hashable {
    public let currentWeight: WeightMeasurement?
    public let currentHeight: HeightMeasurement?
    public let pastWeights: [WeightMeasurement]
    public let pastHeights: [HeightMeasurement]
    
    public init(currentWeight: WeightMeasurement?, currentHeight: HeightMeasurement?, pastWeights: [WeightMeasurement], pastHeights: [HeightMeasurement]) {
        self.currentWeight = currentWeight
        self.currentHeight = currentHeight
        self.pastWeights = pastWeights
        self.pastHeights = pastHeights
    }
}

public extension BodyMeasurements {
    static var empty: BodyMeasurements {
        BodyMeasurements(
            currentWeight: nil,
            currentHeight: nil,
            pastWeights: [],
            pastHeights: []
        )
    }
}
