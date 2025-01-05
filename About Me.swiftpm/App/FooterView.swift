import SwiftUI

struct FooterView: View {
    let information: Info
    
    var body: some View {
        Text("Coded By: \(information.name)")
            .foregroundColor(Color.accentColor)
            .font(.caption)
            .padding(EdgeInsets(top: 75, leading: 99, bottom: 0, trailing: 0))
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(information: information)
    }
}
