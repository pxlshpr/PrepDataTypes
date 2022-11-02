import Foundation

public typealias EmptyHandler = (() -> ())
public typealias GetMealsHandler = ((Date) async throws -> [Meal])
