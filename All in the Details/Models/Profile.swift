import Foundation

/// Represents the photographer's profile/bio information
struct PhotographerProfile {
    var name: String
    var bio: String
    var profileImageName: String
    var website: String
    var email: String
    var socialLinks: [SocialLink]
    
    static let placeholder = PhotographerProfile(
        name: "Alex Stanage",
        bio: "A photographer captivated by the cosmos. Specializing in astrophotography and deep-space imaging, I chase the light that has traveled millions of years to reach us. Every frame is a conversation with the universe.",
        profileImageName: "space_profile",
        website: "https://example.com",
        email: "hello@example.com",
        socialLinks: [
            SocialLink(platform: .instagram, url: "https://instagram.com/photographer"),
            SocialLink(platform: .twitter, url: "https://twitter.com/photographer"),
        ]
    )
}

struct SocialLink: Identifiable, Hashable {
    let id = UUID()
    var platform: SocialPlatform
    var url: String
}

enum SocialPlatform: String, CaseIterable, Hashable {
    case instagram = "Instagram"
    case twitter = "X / Twitter"
    case flickr = "Flickr"
    case website = "Website"
    
    var icon: String {
        switch self {
        case .instagram: return "camera.fill"
        case .twitter: return "at"
        case .flickr: return "eye.fill"
        case .website: return "globe"
        }
    }
}
