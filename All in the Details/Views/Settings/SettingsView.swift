import SwiftUI

/// App settings view with appearance, display, and about options
struct SettingsView: View {
    @Environment(PortfolioViewModel.self) private var viewModel
    @Environment(\.colorScheme) private var systemColorScheme
    
    var body: some View {
        @Bindable var vm = viewModel
        NavigationStack {
            List {
                // Appearance
                Section {
                    Picker("Appearance", selection: $vm.isDarkModeOverride) {
                        Text("System").tag(nil as Bool?)
                        Text("Light").tag(false as Bool?)
                        Text("Dark").tag(true as Bool?)
                    }
                    
                    ColorPicker("Accent Color", selection: $vm.accentColor)
                } header: {
                    Text("Appearance")
                } footer: {
                    Text("Dark mode is recommended for the best photo viewing experience.")
                }
                
                // Display
                Section("Display") {
                    Picker("Sort Order", selection: $vm.sortOrder) {
                        ForEach(PortfolioViewModel.SortOrder.allCases, id: \.self) { order in
                            Text(order.rawValue).tag(order)
                        }
                    }
                }
                
                // Portfolio Stats
                Section("Portfolio") {
                    HStack {
                        Text("Total Photos")
                        Spacer()
                        Text("\(viewModel.allPhotos.count)")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Collections")
                        Spacer()
                        Text("\(viewModel.collections.count)")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Categories")
                        Spacer()
                        Text("\(Set(viewModel.allPhotos.map(\.category)).count)")
                            .foregroundStyle(.secondary)
                    }
                }
                
                // About
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Build")
                        Spacer()
                        Text("1")
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Accessibility Info
                Section {
                    NavigationLink {
                        accessibilityInfoView
                    } label: {
                        Label("Accessibility", systemImage: "accessibility")
                    }
                } footer: {
                    Text("This app supports VoiceOver, Dynamic Type, and Reduce Motion.")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var accessibilityInfoView: some View {
        List {
            Section("Supported Features") {
                Label("VoiceOver", systemImage: "speaker.wave.3.fill")
                Label("Dynamic Type", systemImage: "textformat.size")
                Label("Reduce Motion", systemImage: "figure.walk")
                Label("High Contrast", systemImage: "circle.lefthalf.filled")
            }
            
            Section {
                Text("All photos include descriptive accessibility labels. Animations respect the Reduce Motion system setting. All text supports Dynamic Type scaling.")
                    .font(ThemeEngine.Typography.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Accessibility")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
        .environment(PortfolioViewModel())
        .preferredColorScheme(.dark)
}
