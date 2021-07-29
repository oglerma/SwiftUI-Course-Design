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

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .modifier(CustomFontModifier(size: 28))
                    
                    Spacer()
                    
                    AvatarView(showProfile: $showProfile)
                    
                    Button(action: {showUpdate.toggle()}, label: {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36, alignment: .center)
                            .background(Color.white)
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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                        }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(sectionData) { section in
                            GeometryReader { geometry in
                                SectionView(section: section)
                                    .rotation3DEffect(
                                        .degrees(Double(geometry.frame(in: .global).minX - 30) / -20),
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
               
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                    .offset(y: -60)
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
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
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack() {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 32, height: 32, percent: 56, show: .constant(true))
                
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack() {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 32, height: 32, percent: 12, show: .constant(true))
                
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
