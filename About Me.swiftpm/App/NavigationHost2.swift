import SwiftUI

struct NavigationHost2: View {
    @Binding var selectedTab: Int
    @Binding var isExpanded: Bool
    @Binding var mapSelectionText: String

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    TabView(selection: $selectedTab) {
                        TitleView(isExpanded: $isExpanded, selectedTab: $selectedTab)
                            .tabItem { Label("Home", systemImage: "menucard.fill") }
                            .tag(0)

                        GlassHomeView(isExpanded: $isExpanded, selectedTab: $selectedTab, information: information)
                            .tabItem { Label("Social", systemImage: "person.line.dotted.person.fill") }
                            .tag(1)

                        MapView(placeID: "king_of_prussia", selectionText: $mapSelectionText, isExpanded: $isExpanded, selectedTab: $selectedTab)
                            .tabItem { Label("Map", systemImage: "map.circle") }
                            .tag(2)

                        Profile()
                            .tabItem { Label("Profile", systemImage: "laptopcomputer") }
                            .tag(3)
                    }
                    .padding(.top)
                    .background(Color.clear)
                    .ignoresSafeArea(edges: .all)

                    VStack {
                        // Only show shared header for the Glass (Social) tab.
                        if isExpanded && selectedTab == 1 {
                            HeaderView(isExpanded: $isExpanded, selectedTab: $selectedTab, information: information)
                                .transition(.move(edge: .top).combined(with: .opacity))
                                .zIndex(1)
                                .padding(.horizontal)
                                .padding(.top, 8)
                        }
                        Spacer()
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

struct NavigationHost2_Previews: PreviewProvider {
    @State static var sel = 0
    @State static var exp = false
    @State static var mapText = ""

    static var previews: some View {
        NavigationHost2(selectedTab: $sel, isExpanded: $exp, mapSelectionText: $mapText)
    }
}
