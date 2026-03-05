import SwiftUI

/// Full-bleed hero image with parallax scrolling effect
struct ParallaxHeroView: View {
    let photo: Photo
    let height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .scrollView).minY
            let parallaxOffset = minY > 0 ? -minY * ThemeEngine.Animations.parallaxFactor : 0
            let stretchHeight = minY > 0 ? height + minY : height
            
            PlaceholderImageView(photo.imageName)
                .frame(width: geometry.size.width, height: stretchHeight)
                .clipped()
                .offset(y: minY > 0 ? -minY : parallaxOffset)
                .overlay(alignment: .bottomLeading) {
                    // Gradient overlay with title
                    VStack(alignment: .leading, spacing: ThemeEngine.Spacing.xs) {
                        Text(photo.title)
                            .font(ThemeEngine.Typography.largeTitle)
                            .foregroundStyle(.white)
                        
                        Text(photo.caption)
                            .font(ThemeEngine.Typography.body)
                            .foregroundStyle(.white.opacity(0.8))
                            .lineLimit(2)
                    }
                    .padding(ThemeEngine.Spacing.lg)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            colors: [.clear, .black.opacity(0.7)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
                
        }
        .frame(height: height)
    }
}
