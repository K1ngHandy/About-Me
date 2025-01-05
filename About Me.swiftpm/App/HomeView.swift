/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct HomeView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Int
    
    let logoImage = information.logoImage
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(information: information, isExpanded: $isExpanded, selectedTab: $selectedTab)
            
            if isExpanded {
                ExpandedContentView(logoImage: logoImage, links: information.links)
                .onAppear {
                    selectedTab = 1
                }
            } else {
                CollapsedContentView(logoImage: logoImage)
            }
            
            FooterView(information: information)
        }
        .padding(9)
        .onChange(of: isExpanded) { newValue in
            print("Selected tab: \(newValue)")
            if !newValue {
                selectedTab = 0
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
