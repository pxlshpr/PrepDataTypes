import Foundation

public protocol SearchDataProvider {
    var recentFoods: [Food] { get }
    func getFoods(scope: SearchScope, searchText: String, page: Int) async throws -> (foods: [Food], haveMoreResults: Bool)
}
