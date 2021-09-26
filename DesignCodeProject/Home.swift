//
//  Home.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 6/16/21.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    var body: some View {
        ZStack {
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, 44)
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    .background(Color("background1"))
                )
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(
                    .degrees(showProfile ? Double(viewState.height / 10) - 10 : 0),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        viewState = value.translation
                    }.onEnded { value in
                        if viewState.height > 50 {
                            showProfile = false
                        }
                        viewState = .zero
                    }
                )
            
            if showContent {
				BlurView(style: .systemMaterial).edgesIgnoringSafeArea(.all)
                ContentView()
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    showContent = false
                }
            }
            

        }
        

        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
		Home().environment(\.colorScheme, .dark)
			.environment(\.sizeCategory, .extraExtraExtraLarge)
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: { showProfile.toggle()}){
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36, alignment: .center)
                .clipShape(Circle())
            
        }
    }
}

let screen = UIScreen.main.bounds
