import SwiftUI

struct CollapsedContentView: View {
    let logoImage: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(logoImage)
                .resizable()
                .cornerRadius(15)
                .frame(width: 50, height: 50)

            Text("Expand for more...")
                .padding(.leading)
                .font(.title2)
                .opacity(0.75)
        }
        .transition(.slide)
    }
}

struct CollapsedContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollapsedContentView(logoImage: information.logoImage)
    }
}