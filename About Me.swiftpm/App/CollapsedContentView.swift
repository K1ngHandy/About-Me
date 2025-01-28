import SwiftUI

struct CollapsedContentView: View {
	@Binding var isExpanded: Bool
	let information: Info
    
    var body: some View {
		let links = information.links
		
        HStack(alignment: .top) {
			LogoImage(isExpanded: $isExpanded, information: information)
//			How to fade LogoImage in/out?
//			Add tap listener to "Expand for more..."

			VStack {
				Text("Expand for more...")
					.padding(.top)
					.font(.title2)
					.opacity(0.75)
				
				HStack {
					Image(links[4].image)
						.resizable()
						.frame(width: 24, height: 24)
					Image(links[3].image)
						.resizable()
						.frame(width: 24, height: 24)
					Image(links[2].image)
						.resizable()
						.frame(width: 24, height: 24)
				}
			}
        }
    }
}

struct CollapsedContentView_Previews: PreviewProvider {
	@State static var isExpanded = false
	
    static var previews: some View {
        CollapsedContentView(isExpanded: $isExpanded, information: information)
    }
}
