import SwiftUI

/// Displays a photo from the asset catalog by name
struct PlaceholderImageView: View {
    let imageName: String
    let aspectRatio: CGFloat?
    
    init(_ imageName: String, aspectRatio: CGFloat? = nil) {
        self.imageName = imageName
        self.aspectRatio = aspectRatio
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .if(aspectRatio != nil) { view in
                view.aspectRatio(aspectRatio, contentMode: .fill)
            }
    }
}

// MARK: - Conditional modifier

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
