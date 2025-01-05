//Created by Steve Handy on 2024.12.26.

import SwiftUI

struct HeaderView: View {
    let information: Info
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Int
    
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
				if selectedTab == 0 {
					selectedTab = 1
				} else {
					selectedTab = 0
				}
				isExpanded.toggle()
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var isExpanded = true
    @State static var selectedTab = 0

    static var previews: some View {
        HeaderView(information: information, isExpanded: $isExpanded, selectedTab: $selectedTab)
    }
}
