import SwiftUI

/// Primary portfolio gallery view with hero image and masonry grid
struct GalleryView: View {
    @Environment(PortfolioViewModel.self) private var viewModel
    @State private var selectedPhoto: Photo?
    
    private let columns = [
        GridItem(.flexible(), spacing: ThemeEngine.Spacing.sm),
        GridItem(.flexible(), spacing: ThemeEngine.Spacing.sm)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    // Hero Section
                    if let hero = viewModel.heroPhoto {
                        Button {
                            selectedPhoto = hero
                        } label: {
                            ParallaxHeroView(
                                photo: hero,
                                height: 420
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    
                    // Category Filter
                    categoryFilter
                        .padding(.top, ThemeEngine.Spacing.lg)
                        .padding(.bottom, ThemeEngine.Spacing.md)
                    
                    // Search bar
                    searchBar
                        .padding(.horizontal, ThemeEngine.Spacing.md)
                        .padding(.bottom, ThemeEngine.Spacing.md)
                    
                    // Photo Grid
                    LazyVGrid(columns: columns, spacing: ThemeEngine.Spacing.sm) {
                        ForEach(viewModel.filteredPhotos) { photo in
                            Button {
                                selectedPhoto = photo
                            } label: {
                                PhotoGridItem(photo: photo)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, ThemeEngine.Spacing.md)
                    .padding(.bottom, ThemeEngine.Spacing.xxl)
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Portfolio")
            .navigationBarTitleDisplayMode(.large)
            .fullScreenCover(item: $selectedPhoto) { photo in
                PhotoDetailView(photo: photo)
            }
        }
    }
    
    // MARK: - Category Filter
    
    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: ThemeEngine.Spacing.sm) {
                categoryChip(nil, label: "All")
                ForEach(PhotoCategory.allCases, id: \.self) { category in
                    categoryChip(category, label: category.rawValue)
                }
            }
            .padding(.horizontal, ThemeEngine.Spacing.md)
        }
    }
    
    private func categoryChip(_ category: PhotoCategory?, label: String) -> some View {
        @Bindable var vm = viewModel
        let isSelected = viewModel.selectedCategory == category
        return Button {
            withAnimation(ThemeEngine.Animations.quickSpring) {
                vm.selectedCategory = category
            }
        } label: {
            Text(label)
                .font(ThemeEngine.Typography.caption)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.primary : Color.clear)
                )
                .foregroundStyle(isSelected ? Color(uiColor: .systemBackground) : .primary)
                .overlay(
                    Capsule()
                        .strokeBorder(Color.primary.opacity(0.3), lineWidth: isSelected ? 0 : 1)
                )
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Search Bar
    
    private var searchBar: some View {
        @Bindable var vm = viewModel
        return HStack(spacing: ThemeEngine.Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("Search photos...", text: $vm.searchText)
                .textFieldStyle(.plain)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
        )
    }
}

#Preview {
    GalleryView()
        .environment(PortfolioViewModel())
        .preferredColorScheme(.dark)
}
