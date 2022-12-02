import Foundation

public struct GoalSet: Identifiable, Hashable, Codable {
    
    public let id: UUID

    public var name: String
    public var emoji: String
    public var goals: [Goal] = []
    public var type: GoalSetType

    public var syncStatus: SyncStatus
    public var updatedAt: Double
    public var deletedAt: Double?
    
    public init(
        id: UUID = UUID(),
        type: GoalSetType = .day,
        name: String,
        emoji: String,
        goals: [Goal] = [],
        syncStatus: SyncStatus = .notSynced,
        updatedAt: Double = Date().timeIntervalSinceNow,
        deletedAt: Double? = nil
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.emoji = emoji
        self.goals = goals
        self.syncStatus = syncStatus
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}

public extension GoalSet {
    var containsWorkoutDurationDependentGoal: Bool {
        goals.contains(where: { $0.dependsOnWorkoutDuration })
    }
}

//MARK: - Implicit (Auto-generated) Goals

public extension GoalSet {
    
    func implicitEnergyGoal(with params: GoalCalcParams) -> Goal? {
        calculateMissingGoal(energy: nil, carb: carbGoal, fat: fatGoal, protein: proteinGoal, with: params)
    }
    func implicitCarbGoal(with params: GoalCalcParams) -> Goal? {
        calculateMissingGoal(energy: energyGoal, carb: nil, fat: fatGoal, protein: proteinGoal, with: params)
    }
    func implicitFatGoal(with params: GoalCalcParams) -> Goal? {
        calculateMissingGoal(energy: energyGoal, carb: carbGoal, fat: nil, protein: proteinGoal, with: params)
    }
    func implicitProteinGoal(with params: GoalCalcParams) -> Goal? {
        calculateMissingGoal(energy: energyGoal, carb: carbGoal, fat: fatGoal, protein: nil, with: params)
    }

    var energyGoal: Goal? { goals.first(where: { $0.type.isEnergy }) }
    var carbGoal: Goal? { goals.first(where: { $0.type.macro == .carb }) }
    var fatGoal: Goal? { goals.first(where: { $0.type.macro == .fat }) }
    var proteinGoal: Goal? { goals.first(where: { $0.type.macro == .protein }) }
}

func calculateMissingGoal(
    energy: Goal?,
    carb: Goal?,
    fat: Goal?,
    protein: Goal?,
    with params: GoalCalcParams
) -> Goal? {
    
    if energy == nil {
        guard let carb, let fat, let protein else { return nil }
        guard let carbLower = carb.lowerBoundForAutoGoal(with: params),
              let carbUpper = carb.upperOrLower(with: params),
              let fatLower = fat.lowerBoundForAutoGoal(with: params),
              let fatUpper = fat.upperOrLower(with: params),
              let proteinLower = protein.lowerBoundForAutoGoal(with: params),
              let proteinUpper = protein.upperOrLower(with: params)
        else { return nil }
        
        var lower = calculateEnergy(c: carbLower, f: fatLower, p: proteinLower)
        var upper = calculateEnergy(c: carbUpper, f: fatUpper, p: proteinUpper)

        /// Now make sure the values are the minimum we would recommend for AutoGoals
        let min = params.userUnits.energy.minimumValueForAutoGoals(params: params)
        lower = max(lower, min)
        upper = max(upper, min)
        
        return createAutoGoal(
            lower: lower,
            upper: upper,
            existingGoals: [carb, fat, protein],
            params: params,
            type: .energy(.fixed(params.userUnits.energy))
        )
    }
    
    if carb == nil {
        guard let energy, let fat, let protein else { return nil }
        guard let energyLower = energy.lowerBoundForAutoGoal(with: params),
              let energyUpper = energy.upperOrLower(with: params),
              let fatLower = fat.lowerBoundForAutoGoal(with: params),
              let fatUpper = fat.upperOrLower(with: params),
              let proteinLower = protein.lowerBoundForAutoGoal(with: params),
              let proteinUpper = protein.upperOrLower(with: params)
        else { return nil }
        
        /// For macros, we match the lower bound of energy with upper bounds of macros and vice versa to get the true range of values
        /// (since the equation dictates that we get the macro by subtracting the sum of the rest from energy)
        var lower = calculateCarb(e: energyLower, f: fatUpper, p: proteinUpper)
        var upper = calculateCarb(e: energyUpper, f: fatLower, p: proteinLower)

        /// Now make sure the values are the minimum we would recommend for AutoGoals
        let min = Macro.carb.minimumValueForAutoGoals
        lower = max(lower, min)
        upper = max(upper, min)

        return createAutoGoal(
            lower: lower,
            upper: upper,
            existingGoals: [energy, fat, protein],
            params: params,
            type: .macro(.fixed, .carb)
        )
    }
    
    if fat == nil {
        guard let energy, let carb, let protein else { return nil }
        guard let energyLower = energy.lowerBoundForAutoGoal(with: params),
              let energyUpper = energy.upperOrLower(with: params),
              let carbLower = carb.lowerBoundForAutoGoal(with: params),
              let carbUpper = carb.upperOrLower(with: params),
              let proteinLower = protein.lowerBoundForAutoGoal(with: params),
              let proteinUpper = protein.upperOrLower(with: params)
        else { return nil }
        
        /// For macros, we match the lower bound of energy with upper bounds of macros and vice versa to get the true range of values
        /// (since the equation dictates that we get the macro by subtracting the sum of the rest from energy)
        var lower = calculateFat(e: energyLower, c: carbUpper, p: proteinUpper)
        var upper = calculateFat(e: energyUpper, c: carbLower, p: proteinLower)

        /// Now make sure the values are the minimum we would recommend for AutoGoals
        let min = Macro.fat.minimumValueForAutoGoals
        lower = max(lower, min)
        upper = max(upper, min)

        return createAutoGoal(
            lower: lower,
            upper: upper,
            existingGoals: [energy, carb, protein],
            params: params,
            type: .macro(.fixed, .fat)
        )
    }
    
    if protein == nil {
        guard let energy, let fat, let carb else { return nil }
        guard let energyLower = energy.lowerBoundForAutoGoal(with: params),
              let energyUpper = energy.upperOrLower(with: params),
              let fatLower = fat.lowerBoundForAutoGoal(with: params),
              let fatUpper = fat.upperOrLower(with: params),
              let carbLower = carb.lowerBoundForAutoGoal(with: params),
              let carbUpper = carb.upperOrLower(with: params)
        else { return nil }
        
        /// For macros, we match the lower bound of energy with upper bounds of macros and vice versa to get the true range of values
        /// (since the equation dictates that we get the macro by subtracting the sum of the rest from energy)
        var lower = calculateProtein(e: energyLower, f: fatUpper, c: carbUpper)
        var upper = calculateProtein(e: energyUpper, f: fatLower, c: carbLower)

        /// Now make sure the values are the minimum we would recommend for AutoGoals
        let min = Macro.protein.minimumValueForAutoGoals
        lower = max(lower, min)
        upper = max(upper, min)

        return createAutoGoal(
            lower: lower,
            upper: upper,
            existingGoals: [energy, fat, carb],
            params: params,
            type: .macro(.fixed, .protein)
        )
    }
    
    return nil
}

func createAutoGoal(
    lower: Double,
    upper: Double,
    existingGoals: [Goal],
    params: GoalCalcParams,
    type: GoalType
) -> Goal {
    var pickedLower: Double? = lower
    var pickedUpper: Double? = upper
    /// If we've got only one value (implying that none of the macros have both bounds)
    if lower.rounded(toPlaces: 2) == upper.rounded(toPlaces: 2) {
        /// Keep the side that's prevalent amongst the macros
        if existingGoals.isPredominantlyLowerBounded {
            pickedUpper = nil
        } else {
            pickedLower = nil
        }
    }
    
    return Goal(type: type, lowerBound: pickedLower, upperBound: pickedUpper)
}

func calculateEnergy(c: Double, f: Double, p: Double) -> Double {
    (c * KcalsPerGramOfCarb) + (f * KcalsPerGramOfFat) + (p * KcalsPerGramOfProtein)
}

func calculateCarb(e: Double, f: Double, p: Double) -> Double {
    (e - ((f * KcalsPerGramOfFat) + (p * KcalsPerGramOfProtein))) / KcalsPerGramOfCarb
}

func calculateFat(e: Double, c: Double, p: Double) -> Double {
    (e - ((c * KcalsPerGramOfCarb) + (p * KcalsPerGramOfProtein))) / KcalsPerGramOfFat
}
func calculateProtein(e: Double, f: Double, c: Double) -> Double {
    (e - ((f * KcalsPerGramOfFat) + (c * KcalsPerGramOfCarb))) / KcalsPerGramOfProtein
}
