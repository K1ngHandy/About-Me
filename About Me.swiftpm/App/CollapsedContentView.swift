import SwiftUI

struct CollapsedContentView: View {
    @Binding var isExpanded: Bool
    let information: Info
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Text("Expand for more...")
                    .padding(.top)
                    .font(.title2)
                    .opacity(0.75)
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
