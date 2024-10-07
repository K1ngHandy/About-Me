/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct StoryView: View {
    var body: some View {
        VStack {
            Text("My Profile:")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            if let validURL = information.url {
                HStack {
                    Image(systemName: "link")
                    
                    Link(information.title, destination: validURL)
                        .font(.title3)
                }
            } else {
                Text("URL not available")
                    .padding()
                    .foregroundColor(.red)
            }
            
            Text("By \(information.name)")
                .font(.caption)
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
