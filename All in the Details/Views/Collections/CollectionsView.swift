import SwiftUI

/// Displays all photo collections with cover images and management
struct CollectionsView: View {
    @Environment(PortfolioViewModel.self) private var viewModel
    @State private var showNewCollection = false
    @State private var newCollectionName = ""
    @State private var newCollectionDescription = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: ThemeEngine.Spacing.lg) {
                    ForEach(viewModel.collections) { collection in
                        NavigationLink(value: collection) {
                            CollectionCard(collection: collection)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, ThemeEngine.Spacing.md)
                .padding(.top, ThemeEngine.Spacing.md)
                .padding(.bottom, ThemeEngine.Spacing.xxl)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Collections")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showNewCollection = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                }
            }
            .navigationDestination(for: PhotoCollection.self) { collection in
                CollectionDetailView(collection: collection)
            }
            .alert("New Collection", isPresented: $showNewCollection) {
                TextField("Collection Name", text: $newCollectionName)
                TextField("Description (optional)", text: $newCollectionDescription)
                Button("Cancel", role: .cancel) {
                    newCollectionName = ""
                    newCollectionDescription = ""
                }
                Button("Create") {
                    viewModel.addCollection(name: newCollectionName, description: newCollectionDescription)
                    newCollectionName = ""
                    newCollectionDescription = ""
                }
            }
        }
    }
}

/// A card displaying a collection's cover photo and info
struct CollectionCard: View {
    @Environment(PortfolioViewModel.self) private var viewModel
    let collection: PhotoCollection
    @State private var isAppeared = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Cover photo
            if let cover = viewModel.coverPhoto(for: collection) {
                PlaceholderImageView(cover.imageName, aspectRatio: 16/9)
                    .frame(height: 200)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                    .overlay {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    }
            }
            
            // Info
            VStack(alignment: .leading, spacing: ThemeEngine.Spacing.xs) {
                Text(collection.name)
                    .font(ThemeEngine.Typography.title3)
                    .foregroundStyle(.primary)
                
                HStack {
                    Text("\(collection.photoIDs.count) photos")
                        .font(ThemeEngine.Typography.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(collection.dateModified, style: .date)
                        .font(ThemeEngine.Typography.caption2)
                        .foregroundStyle(.tertiary)
                }
                
                if !collection.description.isEmpty {
                    Text(collection.description)
                        .font(ThemeEngine.Typography.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            .padding(ThemeEngine.Spacing.md)
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .opacity(isAppeared ? 1 : 0)
        .offset(y: isAppeared ? 0 : 30)
        .onAppear {
            withAnimation(ThemeEngine.Animations.heroSpring) {
                isAppeared = true
            }
        }
    }
}

/// Detail view for a single collection showing its photos
struct CollectionDetailView: View {
    @Environment(PortfolioViewModel.self) private var viewModel
    let collection: PhotoCollection
    
    @State private var selectedPhoto: Photo?
    @State private var isEditing = false
    
    private let columns = [
        GridItem(.flexible(), spacing: ThemeEngine.Spacing.sm),
        GridItem(.flexible(), spacing: ThemeEngine.Spacing.sm)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ThemeEngine.Spacing.md) {
                if !collection.description.isEmpty {
                    Text(collection.description)
                        .font(ThemeEngine.Typography.body)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, ThemeEngine.Spacing.md)
                }
                
                let photos = viewModel.photos(in: collection)
                
                if isEditing {
                    // Drag-and-drop reorder list
                    List {
                        ForEach(photos) { photo in
                            HStack(spacing: ThemeEngine.Spacing.md) {
                                PlaceholderImageView(photo.imageName)
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                VStack(alignment: .leading) {
                                    Text(photo.title)
                                        .font(ThemeEngine.Typography.headline)
                                    Text(photo.category.rawValue)
                                        .font(ThemeEngine.Typography.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                            }
                        }
                        .onMove { source, destination in
                            viewModel.movePhotos(in: collection, from: source, to: destination)
                        }
                    }
                    .listStyle(.plain)
                    .frame(minHeight: CGFloat(photos.count) * 80)
                } else {
                    LazyVGrid(columns: columns, spacing: ThemeEngine.Spacing.sm) {
                        ForEach(photos) { photo in
                            Button {
                                selectedPhoto = photo
                            } label: {
                                PhotoGridItem(photo: photo)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, ThemeEngine.Spacing.md)
                }
            }
            .padding(.bottom, ThemeEngine.Spacing.xxl)
        }
        .scrollIndicators(.hidden)
        .navigationTitle(collection.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation(ThemeEngine.Animations.quickSpring) {
                        isEditing.toggle()
                    }
                }
            }
        }
        .fullScreenCover(item: $selectedPhoto) { photo in
            PhotoDetailView(photo: photo)
        }
    }
}

#Preview {
    CollectionsView()
        .environment(PortfolioViewModel())
        .preferredColorScheme(.dark)
}
