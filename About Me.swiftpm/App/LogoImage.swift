//
//  SwiftUIView.swift
//  About Me
//
//  Created by Steve Handy on 2025.01.06.
//

import SwiftUI

struct LogoImage: View {
	@Binding var isExpanded: Bool
	let information: Info
	
    var body: some View {
		let logoImage = information.logoImage
		
		if !isExpanded {
			Image(logoImage)
				.resizable()
				.cornerRadius(15)
				.aspectRatio(contentMode: .fit)
				.frame(width: 120, height: 120)
				.padding(21)
		} else {
			Image(logoImage)
				.resizable()
				.cornerRadius(15)
				.frame(width: 75, height: 75)
		}
    }
}

struct LogoImage_Previews: PreviewProvider {
	@State static var isExpanded = false
	
	static var previews: some View {
		LogoImage(isExpanded: $isExpanded, information: information)
	}
}
