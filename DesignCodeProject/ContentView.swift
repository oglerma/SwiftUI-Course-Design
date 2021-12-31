//
//  ContentView.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 5/30/21.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: show ? 20.0 : 0.0)
                .opacity(showCard ? 0.4 : 1.0)
                .offset(y: showCard ? -200.0 : 0.0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
                )

            BackCardView()
                .frame(maxWidth: showCard ? CGFloat(300) : CGFloat(340))
				.frame(height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20.0)
                .shadow(radius: 20.0)
                .offset(x: 0.0, y: show ? -400.0 : -40.0)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180.0 : 0.0)
                .scaleEffect(showCard ? 1.0 : 0.9)
                .rotationEffect(.degrees(show ? 0.0 : 10.0))
                .rotationEffect(Angle(degrees: showCard ? -10.0 : 0.0))
                .rotation3DEffect(
                    .degrees(showCard ? 0.0 : 10),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))

            BackCardView()
                .frame(maxWidth: 340.0)
				.frame(height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20.0)
                .shadow(radius: 20.0)
                .offset(x: 0.0, y: show ? -200.0 : -20.0)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140.0 : 0.0)
                .scaleEffect(showCard ? 1.0 : 0.95)
                .rotationEffect(Angle(degrees: show ? 0.0 : 5.0))
                .rotationEffect(Angle(degrees: showCard ? -5.0 : 0.0))
                .rotation3DEffect(
                    .degrees(showCard ? 0.0 : 5.0),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))

            CardView()
                .frame(maxWidth: showCard ? CGFloat(375) : CGFloat(340))
				.frame(height: 220)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30.0 : 20.0, style: .continuous))
                .shadow(radius: 20.0)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100.0 : 0.0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3,
                                   dampingFraction: 0.6,
                                   blendDuration: 0.0))
                .onTapGesture {
                    showCard.toggle()
                }
                .gesture(
                DragGesture()
                    .onChanged { value in
                        viewState = value.translation
                        show = true
                    }
                    .onEnded { value in
                        viewState = .zero
                        show = false
                    }
                )
            
			
			GeometryReader { bounds in
            BottomCardView(show: $showCard)
					.offset(x: 0.0, y: showCard ? bounds.size.height / 2 : bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20.0 : 0.0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1.0, duration: 0.8))
                .gesture(
                DragGesture()
                    .onChanged { value in
                        bottomState = value.translation
                        if showFull {
                            bottomState.height += -300
                        }
                        if bottomState.height < -300 {
                            bottomState.height = -300
                        }
                    }
                    .onEnded { value in
                        if bottomState.height > 50 {
                            showCard = false
                        }
                        if (bottomState.height < -100 && !showFull) || (bottomState.height < -250 && showFull) {
                            bottomState.height = -300
                            showFull = true
                        } else {
                            bottomState = .zero
                            showFull = false
                        }
                       
                    }
                )
			}
//			.edgesIgnoringSafeArea(.all)
			// we can do this or just add it ourselves to ignore those areas when we calculate heigth of screen
			// like so: bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
			.previewLayout(.fixed(width: 320, height: 667))
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20.0)
            .padding(.top, 20.0)
            Spacer()
            Image("Card1")
                .resizable() // Resizalbe (Image adapts to the frame)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300.0, height: 110.0, alignment: .top)
            
        }

    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(maxWidth: 375)
            Spacer()
        }
    }
}

struct BottomCardView: View {
    @Binding var show: Bool
    var body: some View {
        VStack {
            
            Rectangle()
                .frame(width: 40.0, height: 5.0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(3.0)
                .opacity(0.1)
            
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval form a Design+Code instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4.0)
            
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 77, show: $show)
                    .animation(Animation.easeInOut.delay(0.3))
                
                VStack(alignment: .leading, spacing: 8){
                    Text("SwiftUI course")
                        .fontWeight(.bold)
                    
                    Text("12 of 12 completed\n10 hours completed")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                
            }
            
            Spacer()
            
        }
        .padding(.top, 8.0)
        .padding(.horizontal, 20.0)
        .frame(maxWidth: 712)
		.background(BlurView(style: .systemUltraThinMaterial))
        .cornerRadius(30.0)
        .shadow(radius: 20.0)
		.frame(maxWidth: .infinity)
        
    }
}
