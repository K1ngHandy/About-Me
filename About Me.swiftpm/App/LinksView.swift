import SwiftUI

struct LinksView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Int

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(information: information, isExpanded: $isExpanded, selectedTab: $selectedTab)

            ExpandedContentView(logoImage: information.logoImage, links: information.links)

            FooterView(information: information)
        }
        .padding(9)
    }
}

struct LinksView_Previews: PreviewProvider {
    @State static var isExpanded = false
    @State static var selectedTab = 0

    static var previews: some View {
        LinksView(isExpanded: $isExpanded, selectedTab: $selectedTab)
    }
}