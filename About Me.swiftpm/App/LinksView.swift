import SwiftUI

struct LinksView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Int
	let information: Info

    var body: some View {
        VStack(alignment: .leading) {
			if isExpanded {
				HeaderView(isExpanded: $isExpanded, selectedTab: $selectedTab, information: information)
				
				ExpandedContentView(isExpanded: $isExpanded, information: information)
				
				FooterView(information: information)
			} else {
				CollapsedContentView(isExpanded: $isExpanded, information: information)
			}
        }
        .padding(9)
    }
}

struct LinksView_Previews: PreviewProvider {
	@State static var isExpanded = true
	@State static var selectedTab = 1

    static var previews: some View {
		LinksView(isExpanded: $isExpanded, selectedTab: $selectedTab, information: information)
    }
}
