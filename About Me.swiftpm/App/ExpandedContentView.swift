import SwiftUI

struct ExpandedContentView: View {
    let logoImage: String
    let links: [(url: URL, image: String, title: String)]
    
    var body: some View {
        VStack(alignment: .center) {
            Image(logoImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(15)
                .padding(21)

            if !links.isEmpty {
                    Links()
            } else {
                Text("Links not available")
                    .padding()
                    .foregroundColor(.red)
            }
        }
        .transition(.slide)
    }
}

struct ExpandedContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedContentView(logoImage: information.logoImage, links: information.links)
    }
}
