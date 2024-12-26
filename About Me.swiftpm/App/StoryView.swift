/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct StoryView: View {
    var body: some View {
        VStack {
            Text("Profile:")
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }
        .padding([.top, .bottom], 50)
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
