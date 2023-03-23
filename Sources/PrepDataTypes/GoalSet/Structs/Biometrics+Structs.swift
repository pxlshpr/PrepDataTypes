import Foundation

extension Biometrics {
    
    public struct RestingEnergy: Hashable, Codable {
        public var amount: Double? {
            didSet {
                self.amount = self.amount?.rounded(toPlaces: 1)
            }
        }
        public var unit: EnergyUnit
        public var source: RestingEnergySource?
        public var equation: RestingEnergyEquation?
        public var interval: HealthInterval?
        
        public init(
            amount: Double? = nil,
            unit: EnergyUnit,
            source: RestingEnergySource? = nil,
            equation: RestingEnergyEquation? = nil,
            interval: HealthInterval? = nil
        ) {
            self.amount = amount?.rounded(toPlaces: 1)
            self.unit = unit
            self.source = source
            self.equation = equation
            self.interval = interval
        }
        
        public mutating func convert(to newUnit: EnergyUnit) {
            guard let amount else { return }
            self.amount = self.unit.convert(amount, to: newUnit)
            self.unit = newUnit
        }
    }

    public struct ActiveEnergy: Hashable, Codable {
        public var amount: Double? {
            didSet {
                self.amount = self.amount?.rounded(toPlaces: 1)
            }
        }
        public var unit: EnergyUnit
        public var source: ActiveEnergySource?
        public var activityLevel: ActivityLevel?
        public var interval: HealthInterval?
        
        public init(
            amount: Double? = nil,
            unit: EnergyUnit,
            source: ActiveEnergySource? = nil,
            activityLevel: ActivityLevel? = nil,
            interval: HealthInterval? = nil
        ) {
            self.amount = amount?.rounded(toPlaces: 1)
            self.unit = unit
            self.source = source
            self.activityLevel = activityLevel
            self.interval = interval
        }
        
        public mutating func convert(to newUnit: EnergyUnit) {
            guard let amount else { return }
            self.amount = self.unit.convert(amount, to: newUnit)
            self.unit = newUnit
        }
    }

    public struct LeanBodyMass: Hashable, Codable {
        public var amount: Double?
        public var unit: BodyMassUnit
        public var source: LeanBodyMassSource?
        public var equation: LeanBodyMassEquation?
        public var sampledAt: Double?

        public init(amount: Double? = nil, unit: BodyMassUnit, source: LeanBodyMassSource? = nil, equation: LeanBodyMassEquation? = nil, date: Date? = nil) {
            self.amount = amount
            self.unit = unit
            self.source = source
            self.equation = equation
            self.sampledAt = date?.timeIntervalSince1970
        }
        
        public var sampleDate: Date? {
            guard let sampledAt else { return nil }
            return Date(timeIntervalSince1970: sampledAt)
        }
        
        public mutating func convert(to newUnit: BodyMassUnit) {
            guard let amount else { return }
            self.amount = self.unit.convert(amount, to: newUnit)
            self.unit = newUnit
        }
    }
    
    public struct Weight: Hashable, Codable {
        public var amount: Double?
        public var unit: BodyMassUnit
        public var source: MeasurementSource?
        public var sampledAt: Double?
        
        public init(amount: Double? = nil, unit: BodyMassUnit, source: MeasurementSource? = nil, date: Date? = nil) {
            self.amount = amount
            self.unit = unit
            self.source = source
            self.sampledAt = date?.timeIntervalSince1970
        }
        
        public var sampleDate: Date? {
            guard let sampledAt else { return nil }
            return Date(timeIntervalSince1970: sampledAt)
        }
        
        public mutating func convert(to newUnit: BodyMassUnit) {
            guard let amount else { return }
            self.amount = self.unit.convert(amount, to: newUnit)
            self.unit = newUnit
        }
    }

    public struct Height: Hashable, Codable {
        public var amount: Double?
        public var unit: HeightUnit
        public var source: MeasurementSource?
        public var sampledAt: Double?
        
        public init(amount: Double? = nil, unit: HeightUnit, source: MeasurementSource? = nil, date: Date? = nil) {
            self.amount = amount
            self.unit = unit
            self.source = source
            self.sampledAt = date?.timeIntervalSince1970
        }

        public var sampleDate: Date? {
            guard let sampledAt else { return nil }
            return Date(timeIntervalSince1970: sampledAt)
        }
        
        public mutating func convert(to newUnit: HeightUnit) {
            guard let amount else { return }
            self.amount = self.unit.convert(amount, to: newUnit)
            self.unit = newUnit
        }
    }

    public struct Sex: Hashable, Codable {
        public var value: BiometricSex?
        public var source: MeasurementSource?
        
        public init(value: BiometricSex? = nil, source: MeasurementSource? = nil) {
            self.value = value
            self.source = source
        }
    }

    public struct Age: Hashable, Codable {
        public var value: Int?
        public var dobDay: Int?
        public var dobMonth: Int?
        public var dobYear: Int?
        public var source: MeasurementSource?
        
        public init(
            value: Int? = nil,
            dobDay: Int? = nil,
            dobMonth: Int? = nil,
            dobYear: Int? = nil,
            source: MeasurementSource? = nil
        ) {
            self.value = value
            self.dobDay = dobDay
            self.dobMonth = dobMonth
            self.dobYear = dobYear
            self.source = source
        }
        
        public init(
            value: Int,
            components: DateComponents,
            source: MeasurementSource
        ) {
            self.value = value
            self.dobDay = components.day
            self.dobMonth = components.month
            self.dobYear = components.year
            self.source = source
        }
    }
}
