import SwiftUI

struct Links: View {
    let links = information.links
    
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

struct Links_Previews: PreviewProvider {
    static var previews: some View {
        Links()
    }
}
