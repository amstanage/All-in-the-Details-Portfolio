import SwiftUI

/// Centralized theme engine managing colors, typography, and spacing
@Observable
final class ThemeEngine {
    var accentColor: Color = .white
    var prefersDarkMode: Bool? = nil // nil = follow system
    
    // MARK: - Colors
    
    struct Colors {
        // Dark mode surfaces
        static let darkBackground = Color.black
        static let darkSurface = Color(red: 28/255, green: 28/255, blue: 30/255)
        static let darkText = Color(red: 245/255, green: 245/255, blue: 247/255)
        static let darkHeading = Color.white
        
        // Light mode surfaces
        static let lightBackground = Color.white
        static let lightSurface = Color(red: 242/255, green: 242/255, blue: 247/255)
        static let lightText = Color(red: 60/255, green: 60/255, blue: 67/255)
        static let lightHeading = Color.black
        
        static let separator = Color.gray.opacity(0.2)
        static let shimmer = Color.white.opacity(0.08)
    }
    
    // MARK: - Typography
    
    struct Typography {
        static let largeTitle = Font.system(.largeTitle, design: .default, weight: .bold)
        static let title = Font.system(.title, design: .default, weight: .semibold)
        static let title2 = Font.system(.title2, design: .default, weight: .semibold)
        static let title3 = Font.system(.title3, design: .default, weight: .medium)
        static let headline = Font.system(.headline, design: .default, weight: .semibold)
        static let body = Font.system(.body, design: .default, weight: .regular)
        static let caption = Font.system(.caption, design: .default, weight: .regular)
        static let caption2 = Font.system(.caption2, design: .default, weight: .regular)
    }
    
    // MARK: - Spacing
    
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
        static let section: CGFloat = 64
    }
    
    // MARK: - Animation
    
    struct Animations {
        static let heroSpring = Animation.spring(response: 0.35, dampingFraction: 0.85)
        static let quickSpring = Animation.spring(response: 0.3, dampingFraction: 0.8)
        static let crossDissolve = Animation.easeInOut(duration: 0.2)
        static let staggerDelay: Double = 0.05
        static let parallaxFactor: CGFloat = 0.3
    }
}

// MARK: - Environment Key

struct ThemeEngineKey: EnvironmentKey {
    static let defaultValue = ThemeEngine()
}

extension EnvironmentValues {
    var themeEngine: ThemeEngine {
        get { self[ThemeEngineKey.self] }
        set { self[ThemeEngineKey.self] = newValue }
    }
}
