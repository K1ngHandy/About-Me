/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct HomeView: View {
    @State private var isExpanded = false
    
    let logoImage = information.logoImage
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(information: information, isExpanded: $isExpanded)
            
            if isExpanded {
                ExpandedContentView(logoImage: logoImage, links: information.links)
            } else {
                CollapsedContentView(logoImage: logoImage)
            }
            
            FooterView(information: information)
        }
        .padding(9)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
