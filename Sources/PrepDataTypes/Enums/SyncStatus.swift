import Foundation

public enum SyncStatus: Int16, Codable {
    case notSynced = 0
    case syncPending
    case synced
}
