//
//  HomeView.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 6/17/21.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
	@Binding var viewState: CGSize
	
	@ObservedObject var store = CourseStore()
	@State var active = false
	@State var activeIndex = -1
	@State var activeView = CGSize.zero
	@Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
		GeometryReader { bounds in
			ScrollView {
				VStack {
					HStack {
						Text("Watching")
							.modifier(CustomFontModifier(size: 28))
						
						Spacer()
						
						AvatarView(showProfile: $showProfile)
						
						Button(action: {showUpdate.toggle()}, label: {
							Image(systemName: "bell")
	//                            .renderingMode(.original)
								.foregroundColor(.primary)
								.font(.system(size: 16, weight: .medium))
								.frame(width: 36, height: 36, alignment: .center)
								.background(Color("background3"))
								.clipShape(Circle())
								.shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1 )
								.shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
						})
						.sheet(isPresented: $showUpdate) {
							UpdateList()
						}
					}
					.padding(.horizontal)
					.padding(.leading, 14)
					.padding(.top, 30)
					.blur(radius: self.active ? 20 : 0)
					
					ScrollView(.horizontal, showsIndicators: false) {
						WatchRingView()
							.padding(.horizontal, 30)
							.padding(.bottom, 30)
							.onTapGesture {
								self.showContent = true
							}
					}
					.blur(radius: self.active ? 20 : 0)

					ScrollView(.horizontal, showsIndicators: false) {
						HStack(spacing: 30) {
							ForEach(sectionData) { section in
								GeometryReader { geometry in
									SectionView(section: section)
										.rotation3DEffect(
											.degrees(Double(geometry.frame(in: .global).minX - 30) / -getAngleMultiplier(bounds: bounds)),
											axis: (x: 0, y: 10.0, z: 0)
										)
								}
								.frame(width: 275, height: 275, alignment: .center)
							}
						}
						.padding(30)
						.padding(.bottom, 30)
					}
					.offset(y: -30)
					.blur(radius: self.active ? 20 : 0)
				   
					HStack {
						Text("Courses")
							.font(.title).bold()
						
						Spacer()
					}
					.padding(.leading, 30)
					.offset(y: -60)
					.blur(radius: self.active ? 20 : 0)
					
					VStack(spacing: 30) {
						ForEach(store.courses.indices, id: \.self) { index in
							GeometryReader { geometry in
								CourseView(
									show: self.$store.courses[index].show,
									course: self.store.courses[index],
									active: self.$active,
									index: index,
									activeIndex: self.$activeIndex,
									activeView: self.$activeView,
									bounds: bounds
								)
									.offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
									.opacity(self.activeIndex != index && self.active ? 0 : 1)
									.scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
									.offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
							}
							.frame(height: horizontalSizeClass == .regular ? 80 : 280)
							.frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(bounds: bounds))
							.zIndex(self.store.courses[index].show ? 1 : 0)
						}
					}
					.padding(.bottom, 300)
					.offset(y: -60)
					
					
					Spacer()
				}
				.frame(width: bounds.size.width)
				.offset(y: showProfile ? -450 : 0)
				.rotation3DEffect(
					.degrees(showProfile ? Double(viewState.height / 10) - 10 : 0),
					axis: (x: 10.0, y: 0.0, z: 0.0)
				)
				.scaleEffect(showProfile ? 0.9 : 1)
				.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
			}
		}
    }
}

func getAngleMultiplier(bounds: GeometryProxy) -> Double {
	if bounds.size.width > 500 {
		return 80
	} else {
		return 20
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
		HomeView(showProfile: .constant(false), showContent: .constant(false), viewState: .constant(.zero))
			.environmentObject(UserStore())
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210, alignment: .center)
            
            
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}


let sectionData = [
    Section(title: "Prototype Designs in swift UI", text: "18 Sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
    Section(title: "iOS and Crypto currency", text: "20 Sections", logo: "Logo2", image: Image(uiImage: #imageLiteral(resourceName: "Background1-Dark") ), color: Color("card2")),
    Section(title: "SwiftUI advanced techniques", text: "20 Sections", logo: "Logo3", image: Image(uiImage: #imageLiteral(resourceName: "Card4")), color: Color("card3"))
]

struct WatchRingView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 66, show: .constant(true))
                VStack(alignment: .leading, spacing: 4) {
                    Text("6 min left")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("Watched 10 min today")
                        .font(.caption)
                    
                }
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack() {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 32, height: 32, percent: 56, show: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack() {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 32, height: 32, percent: 12, show: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
