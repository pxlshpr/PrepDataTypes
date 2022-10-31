import Foundation
import CoreData

public struct Day: Identifiable {
    
    public var id: UUID
    public var name: String
    public var emoji: String
    public var detail: String?
    public var brand: String?
    public var barcodes: String
    public var publishStatus: UserFoodPublishStatus
    public var info: UserFoodInfo
    public var syncStatus: SyncStatus
    
}

//MARK: UserFoodCreateForm → UserFood
public extension Day {
    init(from form: UserFoodCreateForm) {
        self.id = form.id
        self.name = form.name
        self.emoji = form.emoji
        self.detail = form.detail
        self.brand = form.brand
        self.barcodes = form.info.barcodes.map { $0.payload }.joined(separator: ";")
        self.publishStatus = form.publishStatus
        self.info = form.info
        
        self.syncStatus = .notSynced
    }
}
