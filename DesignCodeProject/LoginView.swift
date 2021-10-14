//
//  LoginView.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 10/12/21.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
		ZStack(alignment: .top) {
			Color.black.edgesIgnoringSafeArea(.all)
			
			Color("background2")
				.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
				.edgesIgnoringSafeArea(.bottom)
			VStack {
				GeometryReader { geometry in
					Text("Learn design & code. \nFrom scratch.")
						.font(.system(size: geometry.size.width/10, weight: .bold))
						.foregroundColor(Color.white)
				}
				.frame(maxWidth: 375, maxHeight: 100)
				.padding(.horizontal, 16)
				
				Text("80 hours of courses for SwiftUI, React and design tools.")
					.font(.subheadline)
					.frame(width: 250)
				Spacer()
			}
			.multilineTextAlignment(.center)
			.padding(.top, 100)
			.frame(height: 477)
			.frame(maxWidth: .infinity)
			.background(
				ZStack {
					Image(uiImage: #imageLiteral(resourceName: "Blob"))
						.offset(x: -250, y: -100)
						.blendMode(.plusDarker)
					
					Image(uiImage: #imageLiteral(resourceName: "Blob"))
						.offset(x: -200, y: -250)
						.blendMode(.overlay)
				}
			)
			.background(Image(uiImage: #imageLiteral(resourceName: "Card3")), alignment: .bottom)
			.background(Color(#colorLiteral(red: 0.4118218422, green: 0.4703363776, blue: 0.9687085748, alpha: 1)))
			.clipShape(RoundedRectangle(cornerRadius: 30.0,style: .continuous))
		}
		
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
