import SwiftUI

struct ExpandedContentView: View {
	@Binding var isExpanded: Bool
	let information: Info
    
    var body: some View {
		ZStack {
			VStack(alignment: .center) {
				LogoImage(isExpanded: $isExpanded, information: information)

			if !information.links.isEmpty {
				Links()
			} else {
				Text("Links not available")
						.padding()
						.foregroundColor(.red)
				}
			}
		}
    }
}

struct ExpandedContentView_Previews: PreviewProvider {
	@State static var isExpanded = true
	
    static var previews: some View {
		ExpandedContentView(isExpanded: $isExpanded, information: information)
    }
}
