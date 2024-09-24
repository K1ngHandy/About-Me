/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct StoryView: View {
    var body: some View {
        VStack {
            Text("My Story")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                Text(information.story)
                    .font(.body)
                    .padding()
            }
            
            if let validURL = information.url {
                Text("Visit \(information.title)")
                    .padding()
                    .font(.headline)
                Link(information.title, destination: validURL)
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
