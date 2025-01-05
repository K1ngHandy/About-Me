import SwiftUI

struct LinksView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Int
	
	let logoImage = information.logoImage

    var body: some View {
        VStack(alignment: .leading) {
			if isExpanded {
				HeaderView(information: information, isExpanded: $isExpanded, selectedTab: $selectedTab)
				
				ExpandedContentView(logoImage: logoImage, links: information.links)
				
				FooterView(information: information)
			} else {
				CollapsedContentView(logoImage: logoImage)
			}
        }
        .padding(9)
    }
}

struct LinksView_Previews: PreviewProvider {
	@State static var isExpanded = true
	@State static var selectedTab = 1
	

    static var previews: some View {
        LinksView(isExpanded: $isExpanded, selectedTab: $selectedTab)
    }
}
