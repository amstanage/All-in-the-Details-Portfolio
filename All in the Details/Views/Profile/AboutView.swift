import SwiftUI

/// Photographer bio/about page with profile photo, social links, and contact
struct AboutView: View {
    @Environment(PortfolioViewModel.self) private var viewModel
    @State private var elementsAppeared: Set<String> = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Profile Header
                    profileHeader
                        .fadeInOnAppear(id: "header", appeared: $elementsAppeared)
                    
                    // Bio
                    bioSection
                        .fadeInOnAppear(id: "bio", appeared: $elementsAppeared, delay: 0.1)
                    
                    // Social Links
                    socialLinksSection
                        .fadeInOnAppear(id: "social", appeared: $elementsAppeared, delay: 0.2)
                    
                    // Contact
                    contactSection
                        .fadeInOnAppear(id: "contact", appeared: $elementsAppeared, delay: 0.3)
                    
                    // Stats
                    statsSection
                        .fadeInOnAppear(id: "stats", appeared: $elementsAppeared, delay: 0.4)
                }
                .padding(.bottom, ThemeEngine.Spacing.xxl)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // MARK: - Profile Header
    
    private var profileHeader: some View {
        VStack(spacing: ThemeEngine.Spacing.md) {
            Image(viewModel.profile.profileImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(.white.opacity(0.2), lineWidth: 2)
                }
            
            Text(viewModel.profile.name)
                .font(ThemeEngine.Typography.title)
                .foregroundStyle(.primary)
            
            Text("Film Photographer")
                .font(ThemeEngine.Typography.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, ThemeEngine.Spacing.xl)
    }
    
    // MARK: - Bio
    
    private var bioSection: some View {
        VStack(alignment: .leading, spacing: ThemeEngine.Spacing.sm) {
            Text("About")
                .font(ThemeEngine.Typography.headline)
                .foregroundStyle(.primary)
            
            Text(viewModel.profile.bio)
                .font(ThemeEngine.Typography.body)
                .foregroundStyle(.secondary)
                .lineSpacing(6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, ThemeEngine.Spacing.lg)
        .padding(.vertical, ThemeEngine.Spacing.md)
    }
    
    // MARK: - Social Links
    
    private var socialLinksSection: some View {
        VStack(alignment: .leading, spacing: ThemeEngine.Spacing.md) {
            Text("Connect")
                .font(ThemeEngine.Typography.headline)
                .foregroundStyle(.primary)
            
            ForEach(viewModel.profile.socialLinks) { link in
                Link(destination: URL(string: link.url)!) {
                    HStack(spacing: ThemeEngine.Spacing.md) {
                        Image(systemName: link.platform.icon)
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.primary)
                        
                        Text(link.platform.rawValue)
                            .font(ThemeEngine.Typography.body)
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, ThemeEngine.Spacing.sm)
                }
            }
            
            // Website
            if !viewModel.profile.website.isEmpty {
                Link(destination: URL(string: viewModel.profile.website)!) {
                    HStack(spacing: ThemeEngine.Spacing.md) {
                        Image(systemName: "globe")
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.primary)
                        
                        Text("Website")
                            .font(ThemeEngine.Typography.body)
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, ThemeEngine.Spacing.sm)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, ThemeEngine.Spacing.lg)
        .padding(.vertical, ThemeEngine.Spacing.md)
    }
    
    // MARK: - Contact
    
    @ViewBuilder
    private var contactSection: some View {
        if !viewModel.profile.email.isEmpty {
            VStack(alignment: .leading, spacing: ThemeEngine.Spacing.md) {
                Text("Contact")
                    .font(ThemeEngine.Typography.headline)
                    .foregroundStyle(.primary)
                
                Link(destination: URL(string: "mailto:\(viewModel.profile.email)")!) {
                    HStack(spacing: ThemeEngine.Spacing.md) {
                        Image(systemName: "envelope.fill")
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.primary)
                        
                        Text(viewModel.profile.email)
                            .font(ThemeEngine.Typography.body)
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.right")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, ThemeEngine.Spacing.sm)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, ThemeEngine.Spacing.lg)
            .padding(.vertical, ThemeEngine.Spacing.md)
        }
    }
    
    // MARK: - Stats
    
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: ThemeEngine.Spacing.md) {
            Text("Portfolio")
                .font(ThemeEngine.Typography.headline)
                .foregroundStyle(.primary)
            
            HStack(spacing: ThemeEngine.Spacing.xl) {
                statItem(value: "\(viewModel.allPhotos.count)", label: "Photos")
                statItem(value: "\(viewModel.collections.count)", label: "Collections")
                statItem(
                    value: "\(Set(viewModel.allPhotos.map(\.category)).count)",
                    label: "Categories"
                )
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, ThemeEngine.Spacing.lg)
        .padding(.vertical, ThemeEngine.Spacing.lg)
    }
    
    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: ThemeEngine.Spacing.xs) {
            Text(value)
                .font(ThemeEngine.Typography.title)
                .foregroundStyle(.primary)
            Text(label)
                .font(ThemeEngine.Typography.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Fade-in animation modifier

struct FadeInModifier: ViewModifier {
    let id: String
    @Binding var appeared: Set<String>
    let delay: Double
    
    var hasAppeared: Bool { appeared.contains(id) }
    
    func body(content: Content) -> some View {
        content
            .opacity(hasAppeared ? 1 : 0)
            .offset(y: hasAppeared ? 0 : 20)
            .onAppear {
                withAnimation(ThemeEngine.Animations.heroSpring.delay(delay)) {
                    _ = appeared.insert(id)
                }
            }
    }
}

extension View {
    func fadeInOnAppear(id: String, appeared: Binding<Set<String>>, delay: Double = 0) -> some View {
        modifier(FadeInModifier(id: id, appeared: appeared, delay: delay))
    }
}

#Preview {
    AboutView()
        .environment(PortfolioViewModel())
        .preferredColorScheme(.dark)
}
