/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct FunFactsView: View {
    @State private var funFact = "Click for random fun facts:"
    
    var body: some View {
        VStack {
            Text(funFact)
                .padding()
                .font(.title)
                .frame(minHeight: 270)
            
            Button("Random Fact") {
                funFact = information.funFacts.randomElement()!
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.purple.opacity(0.9), lineWidth: 1.2)
            )
//            change button text color
            .foregroundColor(Color.indigo)
            .padding()
        }
    }
    
}

struct FunFactsView_Previews: PreviewProvider {
    static var previews: some View {
        FunFactsView()
    }
}
