import SwiftUI

struct FooterView: View {
    let information: Info

    var body: some View {
        HStack {
            Spacer()
            Text("Coded by: \(information.name)")
                .foregroundColor(Color.accentColor)
                .font(.caption)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            Spacer()
        }
        // let parent decide final bottom padding so FooterView can be reused
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(information: information)
    }
}
