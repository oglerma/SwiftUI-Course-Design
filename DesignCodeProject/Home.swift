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
	@EnvironmentObject var user: UserStore
    var body: some View {
		ZStack {
			Color("background2")
				.edgesIgnoringSafeArea(.all)
			
			HomeBackgroundView(showProfile: $showProfile)
				.offset(y: showProfile ? -450 : 0)
				.rotation3DEffect(
					.degrees(showProfile ? Double(viewState.height / 10) - 10 : 0),
					axis: (x: 10.0, y: 0.0, z: 0.0)
				)
				.scaleEffect(showProfile ? 0.9 : 1)
				.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
				.edgesIgnoringSafeArea(.all)
			
			
//			TabView {
				HomeView(showProfile: $showProfile,
						 showContent: $showContent,
						 viewState: $viewState)
//					.tabItem {
//						Image(systemName: "play.circle.fill")
//						Text("Home")
//					}
//			}

            
			MenuView(showProfile: $showProfile)
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
			
			if user.showLogin {
				ZStack {
					LoginView()
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
					.padding()
					.onTapGesture {
						self.user.showLogin = false
					}
				}
			}
			
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
			.environmentObject(UserStore())
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool
	@EnvironmentObject var user: UserStore
    
    var body: some View {
		VStack {
			if user.isLogged {
				Button(action: { showProfile.toggle()}){
				Image("Avatar")
					.renderingMode(.original)
					.resizable()
					.frame(width: 36, height: 36, alignment: .center)
					.clipShape(Circle())
				
				}
			} else {
				Button(action: { self.user.showLogin.toggle()}){
					Image(systemName: "person")
						.foregroundColor(.primary)
						.font(.system(size: 16, weight: .medium))
						.frame(width: 36, height: 36, alignment: .center)
						.background(Color("background3"))
						.clipShape(Circle())
						.shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1 )
						.shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
					
				}
			}
		}
    }
}

let screen = UIScreen.main.bounds

struct HomeBackgroundView: View {
	@Binding var showProfile: Bool
	var body: some View {
		VStack {
			LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
				.frame(height: 200)
			Spacer()
		}
		.background(Color("background1"))
		.clipShape(RoundedRectangle(cornerRadius: showProfile ? 30 : 0, style: .continuous))
		.shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
	}
}
