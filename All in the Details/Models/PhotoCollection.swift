import Foundation

/// Represents a named collection/project of photographs
struct PhotoCollection: Identifiable, Hashable {
    let id: UUID
    var name: String
    var description: String
    var coverPhotoID: UUID?
    var photoIDs: [UUID]
    var dateCreated: Date
    var dateModified: Date
    var sortOrder: Int
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String = "",
        coverPhotoID: UUID? = nil,
        photoIDs: [UUID] = [],
        dateCreated: Date = .now,
        dateModified: Date = .now,
        sortOrder: Int = 0
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.coverPhotoID = coverPhotoID
        self.photoIDs = photoIDs
        self.dateCreated = dateCreated
        self.dateModified = dateModified
        self.sortOrder = sortOrder
    }
}
