import Foundation

extension Biometrics {
    
    public struct RestingEnergy: Hashable, Codable, Equatable {
        public var amount: Double?
        public var unit: EnergyUnit
        public var source: RestingEnergySource?
        public var formula: RestingEnergyFormula?
        public var period: HealthPeriodOption?
        public var intervalValue: Int?
        public var interval: HealthAppInterval?
        
        public init(amount: Double? = nil, unit: EnergyUnit, source: RestingEnergySource? = nil, formula: RestingEnergyFormula? = nil, period: HealthPeriodOption? = nil, intervalValue: Int? = nil, interval: HealthAppInterval? = nil) {
            self.amount = amount
            self.unit = unit
            self.source = source
            self.formula = formula
            self.period = period
            self.intervalValue = intervalValue
            self.interval = interval
        }
    }

    public struct ActiveEnergy: Hashable, Codable {
        public var amount: Double?
        public var unit: EnergyUnit
        public var source: ActiveEnergySource?
        public var activityLevel: ActivityLevel?
        public var period: HealthPeriodOption?
        public var intervalValue: Int?
        public var interval: HealthAppInterval?
        
        public init(amount: Double? = nil, unit: EnergyUnit, source: ActiveEnergySource? = nil, activityLevel: ActivityLevel? = nil, period: HealthPeriodOption? = nil, intervalValue: Int? = nil, interval: HealthAppInterval? = nil) {
            self.amount = amount
            self.unit = unit
            self.source = source
            self.activityLevel = activityLevel
            self.period = period
            self.intervalValue = intervalValue
            self.interval = interval
        }
    }

    public struct LeanBodyMass: Hashable, Codable {
        public var amount: Double?
        public var unit: WeightUnit
        public var source: LeanBodyMassSource?
        public var formula: LeanBodyMassFormula?
        public var sampledAt: Double?

        public init(amount: Double? = nil, unit: WeightUnit, source: LeanBodyMassSource? = nil, formula: LeanBodyMassFormula? = nil, date: Date? = nil) {
            self.amount = amount
            self.unit = unit
            self.source = source
            self.formula = formula
            self.sampledAt = date?.timeIntervalSince1970
        }
        
        public var sampleDate: Date? {
            guard let sampledAt else { return nil }
            return Date(timeIntervalSince1970: sampledAt)
        }
    }
    
    public struct Weight: Hashable, Codable {
        public var amount: Double?
        public var unit: WeightUnit
        public var source: MeasurementSource?
        public var sampledAt: Double?
        
        public init(amount: Double? = nil, unit: WeightUnit, source: MeasurementSource? = nil, date: Date? = nil) {
            self.amount = amount
            self.unit = unit
            self.source = source
            self.sampledAt = date?.timeIntervalSince1970
        }
        
        public var sampleDate: Date? {
            guard let sampledAt else { return nil }
            return Date(timeIntervalSince1970: sampledAt)
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
        
        public init(value: Int? = nil, dobDay: Int? = nil, dobMonth: Int? = nil, dobYear: Int? = nil, source: MeasurementSource? = nil) {
            self.value = value
            self.dobDay = dobDay
            self.dobMonth = dobMonth
            self.dobYear = dobYear
            self.source = source
        }
    }
}
