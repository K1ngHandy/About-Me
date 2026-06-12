import SwiftUI

struct NavigationHost: View {
    @Binding var selectedTab: Int
    @Binding var isExpanded: Bool
    @Binding var mapSelectionText: String

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    TabView(selection: $selectedTab) {
                            TitleView(
                            isExpanded: $isExpanded,
                            selectedTab: $selectedTab
                        )
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .tag(0)
    
                        GlassHomeView(
                            isExpanded: $isExpanded,
                            selectedTab: $selectedTab,
                            information: information
                        )
                        .tabItem {
                            Label(
                                "Social",
                                systemImage: "sparkles"
                            )
                        }
                        .tag(1)
    
                        MapView(
                            placeID: "king_of_prussia",
                            selectionText: $mapSelectionText,
                            isExpanded: $isExpanded,
                            selectedTab: $selectedTab
                        )
                        .tabItem {
                            Label("Map", systemImage: "map")
                        }
                        .tag(2)
    
                        Profile()
                            .tabItem {
                                Label("Profile", systemImage: "person")
                            }
                            .tag(3)
                    }
                    .padding(
                        .top
                    )
                    .background(Color.clear)
                    .ignoresSafeArea(edges: .all)
                    VStack {
                        if isExpanded && selectedTab == 1 {
                            Text("Social Overlay")
                                .font(.headline)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.ultraThinMaterial)
                                )
                                .transition(
                                    .move(edge: .top).combined(with: .opacity)
                                )
                                .zIndex(1)
                                .padding(.horizontal)
                                .padding(.top, 8)
                        }
                        Spacer()
                    }
                    // Footer shown only for the Title (Home) tab
                    VStack {
                        Spacer()
                        if selectedTab == 0 {
                            GeometryReader { geo in
                                // GeometryReader used only to read safe area inset; keep height 0 so it doesn't affect layout.
                                FooterView(information: information)
                                    .padding(.horizontal)
                                    // place footer above system tab bar using safe area inset + small offset
                                    .padding(.bottom, geo.safeAreaInsets.bottom + 12)
                            }
                            .frame(height: 0)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack(spacing: 8) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 18, weight: .semibold))
                                .glassEffect(.regular, in: .circle)
                            Text("Liquid Glass")
                                .font(.subheadline.weight(.semibold))
                        }
                        .padding(.horizontal, 8)
                    }
    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .buttonStyle(.glass)
    
                        Button(action: {}) {
                            Image(systemName: "gearshape")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .buttonStyle(.glass)
                    }
                }
            }
            .background(Color.clear)
            .ignoresSafeArea()
        } else {
            // Fallback on earlier versions
        }
    }
}

struct NavigationHost_Previews: PreviewProvider {
    @State static var sel = 0
    @State static var exp = false
    @State static var mapText = ""

    static var previews: some View {
        NavigationHost(selectedTab: $sel, isExpanded: $exp, mapSelectionText: $mapText)
    }
}
