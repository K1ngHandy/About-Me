import SwiftUI

struct HomeView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(information: information, isExpanded: $isExpanded, selectedTab: $selectedTab)
            
            LinksView(isExpanded: $isExpanded, selectedTab: $selectedTab)
            
            FooterView(information: information)
        }
        .padding(9)
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var isExpanded = false
    @State static var selectedTab = 0

    static var previews: some View {
        HomeView(isExpanded: $isExpanded, selectedTab: $selectedTab)
    }
}
