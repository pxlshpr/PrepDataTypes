import Foundation

public enum SyncStatus: Int16, Codable {
    case notSynced = 0
    case syncing
    case synced
}
