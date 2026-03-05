import Foundation
import SwiftUI

/// Represents EXIF metadata for a photograph
struct EXIFData: Identifiable, Hashable, Codable {
    var id = UUID()
    var camera: String
    var lens: String
    var focalLength: String
    var aperture: String
    var shutterSpeed: String
    var iso: String
    var dateTaken: Date?
    
    static let placeholder = EXIFData(
        camera: "Canon EOS R5",
        lens: "RF 24-70mm f/2.8L",
        focalLength: "50mm",
        aperture: "f/2.8",
        shutterSpeed: "1/250s",
        iso: "ISO 400"
    )
}

/// Represents a single photograph in the portfolio
struct Photo: Identifiable, Hashable {
    let id: UUID
    var title: String
    var caption: String
    var tags: [String]
    var category: PhotoCategory
    var imageName: String
    var thumbnailName: String
    var exif: EXIFData
    var dateAdded: Date
    var isFavorite: Bool
    var sortOrder: Int
    
    init(
        id: UUID = UUID(),
        title: String,
        caption: String = "",
        tags: [String] = [],
        category: PhotoCategory = .landscape,
        imageName: String,
        thumbnailName: String? = nil,
        exif: EXIFData = .placeholder,
        dateAdded: Date = .now,
        isFavorite: Bool = false,
        sortOrder: Int = 0
    ) {
        self.id = id
        self.title = title
        self.caption = caption
        self.tags = tags
        self.category = category
        self.imageName = imageName
        self.thumbnailName = thumbnailName ?? imageName
        self.exif = exif
        self.dateAdded = dateAdded
        self.isFavorite = isFavorite
        self.sortOrder = sortOrder
    }
}

enum PhotoCategory: String, CaseIterable, Codable, Hashable {
    case automotive = "Automotive"
    case detail = "Detail"
    case architecture = "Architecture"
    case street = "Street"
    case stillLife = "Still Life"
    case landscape = "Landscape"
    case abstract = "Abstract"
    
    var icon: String {
        switch self {
        case .automotive: return "car.fill"
        case .detail: return "camera.macro"
        case .architecture: return "building.columns.fill"
        case .street: return "building.2.fill"
        case .stillLife: return "cup.and.saucer.fill"
        case .landscape: return "mountain.2.fill"
        case .abstract: return "circle.hexagongrid.fill"
        }
    }
}
