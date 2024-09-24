/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct FunFactsView: View {

    @State private var funFact = "Click for random fun facts:"
    var body: some View {
        VStack {
            Text("Fun Facts")
                .font(.largeTitle)
                .fontWeight(.bold)
                        
            Text(funFact)
                .padding()
                .font(.title)
                .frame(minHeight: 270)

            Button("Show Random Fact") {
                funFact = information.funFacts.randomElement()!
            }
            .padding(9)
            .border(Color.blue, width: 3)
            .cornerRadius(12)
            
        }
        .padding()
    }
}

struct FunFactsView_Previews: PreviewProvider {
    static var previews: some View {
        FunFactsView()
    }
}
