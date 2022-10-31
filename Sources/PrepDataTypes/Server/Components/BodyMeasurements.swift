import Foundation

public struct BodyMeasurements: Codable {
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
