/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct HomeView: View {
    @State private var isExpanded = false
    
    let logoImage = information.image[0]
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(isExpanded: $isExpanded)
            
            if isExpanded {
                ExpandedContentView(logoImage: logoImage)
            } else {
                CollapsedContentView(logoImage: logoImage)
            }
            
            FooterView()
        }
        .padding(9)
    }
}

struct HeaderView: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        HStack {
            Text(information.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Image(systemName: isExpanded ? "chevron.down" : "chevron.up")
                .rotationEffect(.degrees(isExpanded ? 0 : 100))
                .animation(.easeInOut, value: isExpanded)
        }
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
}

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

        .animation(.easeOut(duration: 10), value: logoImage)
    }
}

struct ExpandedContentView: View {
    let logoImage: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(logoImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(15)
                .padding(21)

                if let validURL = information.url {
                    LinkView(url: validURL, title: information.title)
                } else {
                    Text("Links not available")
                        .padding()
                        .foregroundColor(.red)
                }
        }
        .transition(.slide)
    }
}

struct LinkView: View {
    let url: URL
    let title: String
    
    var body: some View {
//        create unordered list of links with icons:
        
        
        
        Link(title, destination: url)
            .font(.title2)
            .padding()
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.purple.opacity(0.9), lineWidth: 1.8)
            )
    }
}

struct FooterView: View {
    var body: some View {
        Text("Coded By: \(information.name)")
            .foregroundColor(Color.accentColor)
            .font(.caption)
            .padding(EdgeInsets(top: 75, leading: 99, bottom: 0, trailing: 0))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
