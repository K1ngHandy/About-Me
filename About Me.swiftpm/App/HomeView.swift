/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct HomeView: View {
	@State private var isExpanded = false
	
    var body: some View {
		VStack(alignment: .leading) {
			VStack {
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
				
				Text(isExpanded ? "" : "Expand for more...")
					.padding(.leading)
					.font(.title2)
					.opacity(0.63)
					.animation(.easeOut, value: isExpanded)
                
                if isExpanded {
                    VStack(alignment: .leading) {
                        Image(information.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(50)
                            .padding(36)
                        
                        if let validURL = information.url {
                            HStack {
                                Image(systemName: "link")
                                
                                Link(information.title, destination: validURL)
                                    .font(.title2)
                            }
                                .font(.subheadline)
                                .padding()
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.purple.opacity(0.9), lineWidth: 1.2)
                                )
                                .padding()
                        } else {
                            Text("Links not available")
                                .padding()
                                .foregroundColor(.red)
                        }
                    }
                    .transition(.slide)
                }
                
                Text("Coded By: \(information.name)")
                    .font(.caption)
                    .padding(EdgeInsets(top: 75, leading: 99, bottom: 0, trailing: 0))
			}
        }
		.padding(9)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
