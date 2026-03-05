import SwiftUI

/// A single photo item in the gallery grid
struct PhotoGridItem: View {
    let photo: Photo
    @State private var isAppeared = false
    
    var body: some View {
        PlaceholderImageView(photo.imageName, aspectRatio: randomAspectRatio)
            .frame(minHeight: 150, maxHeight: 300)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(alignment: .bottomLeading) {
                Text(photo.title)
                    .font(ThemeEngine.Typography.caption)
                    .foregroundStyle(.white)
                    .padding(.horizontal, ThemeEngine.Spacing.sm)
                    .padding(.vertical, ThemeEngine.Spacing.xs)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 4))
                    .padding(ThemeEngine.Spacing.sm)
            }
            .opacity(isAppeared ? 1 : 0)
            .offset(y: isAppeared ? 0 : 20)
            .onAppear {
                withAnimation(ThemeEngine.Animations.heroSpring.delay(Double(photo.sortOrder) * ThemeEngine.Animations.staggerDelay)) {
                    isAppeared = true
                }
            }
    }
    
    private var randomAspectRatio: CGFloat {
        // Vary aspect ratios for masonry effect based on photo
        let ratios: [CGFloat] = [0.75, 0.85, 1.0, 1.2, 0.65]
        let index = abs(photo.imageName.hashValue) % ratios.count
        return ratios[index]
    }
}
