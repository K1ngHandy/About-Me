import SwiftUI

struct TitleView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(isExpanded: $isExpanded, selectedTab: $selectedTab, information: information)

            if isExpanded {
                GlassHomeView(isExpanded: $isExpanded, selectedTab: $selectedTab, information: information)
            } else {
                CollapsedContentView(isExpanded: $isExpanded, information: information)
            }
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

struct TitleView_Previews: PreviewProvider {
    @State static var isExpanded = false
    @State static var selectedTab = 0

    static var previews: some View {
        TitleView(isExpanded: $isExpanded, selectedTab: $selectedTab)
    }
}
