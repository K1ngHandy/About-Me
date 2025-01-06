import SwiftUI

struct HomeView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(isExpanded: $isExpanded, selectedTab: $selectedTab, information: information)
            
			LinksView(isExpanded: $isExpanded, selectedTab: $selectedTab, information: information)
            
            FooterView(information: information)
        }
        .padding(9)
		
		.onChange(of: selectedTab) { newValue in
			print("Selected tab: \(newValue)")
			if newValue != 1 {
				isExpanded = false
			} else if newValue == 1 {
				isExpanded = true
				print("Expanded: \(isExpanded)")
				print("Selected tab: \(selectedTab)")
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var isExpanded = false
    @State static var selectedTab = 0

    static var previews: some View {
        HomeView(isExpanded: $isExpanded, selectedTab: $selectedTab)
    }
}
