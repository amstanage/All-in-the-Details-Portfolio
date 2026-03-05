import Foundation
import SwiftUI

/// Primary view model managing all portfolio state
@Observable
final class PortfolioViewModel {
    // MARK: - Photo State
    var allPhotos: [Photo] = SampleData.spacePhotos
    var collections: [PhotoCollection] = SampleData.collections
    var profile: PhotographerProfile = SampleData.profile
    
    // MARK: - UI State
    var selectedPhoto: Photo?
    var selectedCollection: PhotoCollection?
    var searchText: String = ""
    var selectedCategory: PhotoCategory?
    var sortOrder: SortOrder = .dateNewest
    
    // MARK: - Settings
    var isDarkModeOverride: Bool? = nil
    var accentColor: Color = .white
    
    enum SortOrder: String, CaseIterable {
        case dateNewest = "Newest First"
        case dateOldest = "Oldest First"
        case nameAZ = "Name A–Z"
        case nameZA = "Name Z–A"
        case custom = "Custom Order"
    }
    
    // MARK: - Filtered & Sorted Photos
    
    var filteredPhotos: [Photo] {
        var result = allPhotos
        
        if !searchText.isEmpty {
            let query = searchText.lowercased()
            result = result.filter { photo in
                photo.title.lowercased().contains(query) ||
                photo.caption.lowercased().contains(query) ||
                photo.tags.contains { $0.lowercased().contains(query) }
            }
        }
        
        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }
        
        switch sortOrder {
        case .dateNewest:
            result.sort { $0.dateAdded > $1.dateAdded }
        case .dateOldest:
            result.sort { $0.dateAdded < $1.dateAdded }
        case .nameAZ:
            result.sort { $0.title < $1.title }
        case .nameZA:
            result.sort { $0.title > $1.title }
        case .custom:
            result.sort { $0.sortOrder < $1.sortOrder }
        }
        
        return result
    }
    
    // MARK: - Collection Helpers
    
    func photos(in collection: PhotoCollection) -> [Photo] {
        collection.photoIDs.compactMap { id in
            allPhotos.first { $0.id == id }
        }
    }
    
    func coverPhoto(for collection: PhotoCollection) -> Photo? {
        guard let coverID = collection.coverPhotoID else {
            return photos(in: collection).first
        }
        return allPhotos.first { $0.id == coverID }
    }
    
    // MARK: - Photo Navigation
    
    func nextPhoto(after photo: Photo) -> Photo? {
        guard let index = filteredPhotos.firstIndex(of: photo),
              index + 1 < filteredPhotos.count else { return nil }
        return filteredPhotos[index + 1]
    }
    
    func previousPhoto(before photo: Photo) -> Photo? {
        guard let index = filteredPhotos.firstIndex(of: photo),
              index > 0 else { return nil }
        return filteredPhotos[index - 1]
    }
    
    // MARK: - Mutations
    
    func toggleFavorite(_ photo: Photo) {
        if let index = allPhotos.firstIndex(where: { $0.id == photo.id }) {
            allPhotos[index].isFavorite.toggle()
        }
    }
    
    func updatePhotoDetails(_ photo: Photo, title: String, caption: String, tags: [String]) {
        if let index = allPhotos.firstIndex(where: { $0.id == photo.id }) {
            allPhotos[index].title = title
            allPhotos[index].caption = caption
            allPhotos[index].tags = tags
        }
    }
    
    func addCollection(name: String, description: String = "") {
        let collection = PhotoCollection(name: name, description: description)
        collections.append(collection)
    }
    
    func deleteCollection(_ collection: PhotoCollection) {
        collections.removeAll { $0.id == collection.id }
    }
    
    func addPhoto(_ photo: Photo, to collection: PhotoCollection) {
        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
            if !collections[index].photoIDs.contains(photo.id) {
                collections[index].photoIDs.append(photo.id)
                collections[index].dateModified = .now
            }
        }
    }
    
    func removePhoto(_ photo: Photo, from collection: PhotoCollection) {
        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
            collections[index].photoIDs.removeAll { $0 == photo.id }
            collections[index].dateModified = .now
        }
    }
    
    func movePhotos(in collection: PhotoCollection, from source: IndexSet, to destination: Int) {
        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
            collections[index].photoIDs.move(fromOffsets: source, toOffset: destination)
            collections[index].dateModified = .now
        }
    }
    
    // Hero image — first photo or first from the first collection
    var heroPhoto: Photo? {
        allPhotos.first
    }
}
