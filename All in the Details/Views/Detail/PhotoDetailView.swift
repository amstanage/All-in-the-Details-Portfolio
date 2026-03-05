import SwiftUI

/// Full-screen photo detail view with EXIF data, pinch-to-zoom, and swipe navigation
struct PhotoDetailView: View {
    @Environment(PortfolioViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    
    let photo: Photo
    
    @State private var currentIndex: Int = 0
    @State private var showEXIF = false
    @State private var isImmersive = false
    @State private var dragOffset: CGSize = .zero
    @State private var isDismissing = false
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    private var currentPhoto: Photo {
        let photos = viewModel.filteredPhotos
        guard currentIndex >= 0, currentIndex < photos.count else { return photo }
        return photos[currentIndex]
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // Paging photo viewer — swipe left/right
            TabView(selection: $currentIndex) {
                ForEach(Array(viewModel.filteredPhotos.enumerated()), id: \.element.id) { index, p in
                    ZoomablePhotoView(photo: p) {
                        withAnimation(ThemeEngine.Animations.quickSpring) {
                            isImmersive.toggle()
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .offset(y: dragOffset.height)
            .scaleEffect(dismissScale)
            .gesture(dismissDragGesture)
            
            // UI Overlay (hidden in immersive mode)
            if !isImmersive {
                overlayUI
                    .transition(.opacity)
            }
            
            // EXIF Sheet
            if showEXIF {
                exifOverlay
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .opacity(dismissOpacity)
        .statusBarHidden(isImmersive)
        .persistentSystemOverlays(isImmersive ? .hidden : .automatic)
        .onAppear {
            if let idx = viewModel.filteredPhotos.firstIndex(where: { $0.id == photo.id }) {
                currentIndex = idx
            }
        }
    }
    
    // MARK: - Overlay UI
    
    private var overlayUI: some View {
        VStack {
            // Top bar
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                // Photo counter
                Text("\(currentIndex + 1) / \(viewModel.filteredPhotos.count)")
                    .font(ThemeEngine.Typography.caption)
                    .foregroundStyle(.white.opacity(0.6))
                
                Spacer()
                
                HStack(spacing: ThemeEngine.Spacing.md) {
                    Button {
                        viewModel.toggleFavorite(currentPhoto)
                    } label: {
                        Image(systemName: currentPhoto.isFavorite ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundStyle(currentPhoto.isFavorite ? .red : .white)
                    }
                    
                    Button {
                        withAnimation(ThemeEngine.Animations.quickSpring) {
                            showEXIF.toggle()
                        }
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.horizontal, ThemeEngine.Spacing.lg)
            .padding(.top, ThemeEngine.Spacing.md)
            
            Spacer()
            
            // Bottom info
            VStack(alignment: .leading, spacing: ThemeEngine.Spacing.sm) {
                Text(currentPhoto.title)
                    .font(ThemeEngine.Typography.title2)
                    .foregroundStyle(.white)
                
                Text(currentPhoto.caption)
                    .font(ThemeEngine.Typography.body)
                    .foregroundStyle(.white.opacity(0.8))
                
                // Tags
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: ThemeEngine.Spacing.xs) {
                        ForEach(currentPhoto.tags, id: \.self) { tag in
                            Text("#\(tag)")
                                .font(ThemeEngine.Typography.caption2)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(.ultraThinMaterial, in: Capsule())
                                .foregroundStyle(.white.opacity(0.9))
                        }
                    }
                }
                
                Text(currentPhoto.category.rawValue)
                    .font(ThemeEngine.Typography.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(ThemeEngine.Spacing.lg)
            .background(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.8)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
    
    // MARK: - EXIF Overlay
    
    private var exifOverlay: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: ThemeEngine.Spacing.md) {
                    Text("Camera Details")
                        .font(ThemeEngine.Typography.headline)
                        .foregroundStyle(.white)
                    
                    exifRow(icon: "camera.fill", label: "Camera", value: currentPhoto.exif.camera)
                    exifRow(icon: "scope", label: "Lens", value: currentPhoto.exif.lens)
                    exifRow(icon: "ruler", label: "Focal Length", value: currentPhoto.exif.focalLength)
                    exifRow(icon: "f.cursive.circle", label: "Aperture", value: currentPhoto.exif.aperture)
                    exifRow(icon: "timer", label: "Shutter", value: currentPhoto.exif.shutterSpeed)
                    exifRow(icon: "gauge.high", label: "ISO", value: currentPhoto.exif.iso)
                }
                .padding(ThemeEngine.Spacing.lg)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                .frame(maxWidth: 280)
                .padding(ThemeEngine.Spacing.lg)
            }
        }
    }
    
    private func exifRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: ThemeEngine.Spacing.sm) {
            Image(systemName: icon)
                .frame(width: 20)
                .foregroundStyle(.secondary)
            VStack(alignment: .leading) {
                Text(label)
                    .font(ThemeEngine.Typography.caption2)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(ThemeEngine.Typography.body)
                    .foregroundStyle(.white)
            }
        }
    }
    
    // MARK: - Dismiss Gesture (swipe down)
    
    private var dismissDragGesture: some Gesture {
        DragGesture(minimumDistance: 20)
            .onChanged { value in
                // Only respond to downward drags
                if value.translation.height > 0 {
                    dragOffset = value.translation
                }
            }
            .onEnded { value in
                if value.translation.height > 120 || value.velocity.height > 800 {
                    isDismissing = true
                    dismiss()
                } else {
                    withAnimation(ThemeEngine.Animations.quickSpring) {
                        dragOffset = .zero
                    }
                }
            }
    }
    
    private var dismissScale: CGFloat {
        let progress = min(max(dragOffset.height / 400, 0), 1)
        return 1.0 - (progress * 0.15)
    }
    
    private var dismissOpacity: Double {
        let progress = min(max(dragOffset.height / 400, 0), 1)
        return 1.0 - (progress * 0.4)
    }
}

// MARK: - Zoomable Photo View

/// Individual photo view with pinch-to-zoom and double-tap
struct ZoomablePhotoView: View {
    let photo: Photo
    let onTap: () -> Void
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        PlaceholderImageView(photo.imageName)
            .aspectRatio(contentMode: .fit)
            .scaleEffect(scale)
            .offset(offset)
            .gesture(pinchGesture)
            .gesture(
                scale > 1
                ? DragGesture().onChanged { value in
                    offset = CGSize(
                        width: lastOffset.width + value.translation.width,
                        height: lastOffset.height + value.translation.height
                    )
                }.onEnded { _ in
                    lastOffset = offset
                }
                : nil
            )
            .onTapGesture(count: 2) {
                withAnimation(ThemeEngine.Animations.heroSpring) {
                    if scale > 1 {
                        scale = 1
                        offset = .zero
                        lastScale = 1
                        lastOffset = .zero
                    } else {
                        scale = 2.5
                        lastScale = 2.5
                    }
                }
            }
            .onTapGesture {
                onTap()
            }
    }
    
    private var pinchGesture: some Gesture {
        MagnifyGesture()
            .onChanged { value in
                let newScale = lastScale * value.magnification
                scale = max(1.0, min(newScale, 5.0))
            }
            .onEnded { _ in
                withAnimation(ThemeEngine.Animations.quickSpring) {
                    if scale < 1.2 {
                        scale = 1.0
                        offset = .zero
                        lastOffset = .zero
                    }
                    lastScale = scale
                }
            }
    }
}

#Preview {
    PhotoDetailView(photo: SampleData.spacePhotos[0])
        .environment(PortfolioViewModel())
}
