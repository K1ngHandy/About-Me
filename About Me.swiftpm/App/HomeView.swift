/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text(information.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Image(information.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(50)
                .padding(36)

            Text(information.story)
                .font(.subheadline)
                .padding()
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.purple.opacity(0.9), lineWidth: 1.2)
                )
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
