import Foundation

public enum ChartPeriod: Int, CaseIterable, Codable {
    case day = 1
    case week
    case month
    case sixMonths
    case year
}
