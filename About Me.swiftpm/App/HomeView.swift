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
                ExpandedContentView(logoImage: logoImage)
            } else {
                CollapsedContentView(logoImage: logoImage)
            }
            
            FooterView(information: information)
        }
        .padding(9)
    }
}

struct HeaderView: View {
    let information: Info
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
    }
}

struct ExpandedContentView: View {
    let logoImage: String
    let links = information.links
    
    var body: some View {
        VStack(alignment: .center) {
            Image(logoImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(15)
                .padding(21)

            if !links.isEmpty {
                    LinkView(links: links)
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
    let links: [(url: URL, image: String, title: String)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(links, id: \.url) { link in
                HStack {
                    Image(link.image)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Link(link.title, destination: link.url)
                        .font(.title2)
                }
                .padding(5)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
        }
        .padding()
    }
}

struct FooterView: View {
    let information: Info
    
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
