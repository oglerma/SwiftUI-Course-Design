//
//  PracticeView.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 5/30/21.
//

import SwiftUI

struct PracticeView: View {
    @State var viewState = CGSize.zero
    var body: some View {
        ZStack {
            PracticeCardView()
                .frame(width: 350, height: 220, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(radius: 30)
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0))
                .offset(x: viewState.width, y: viewState.height)
                .gesture(
                DragGesture()
                    .onChanged { value in
                        viewState = value.translation
                    }
                    .onEnded { value in
                        viewState = .zero
                    }
                )
        }
        
        
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}

struct PracticeTitleView: View {
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text("3 Deaths resulted injured!")
                    .font(.headline)
                    .foregroundColor(.white)
                    
               
                Text("Top story of today")
                    .font(.subheadline)
                    .foregroundColor(.black)
                  
            }
            Spacer()
            Image("Logo1")
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 9)
        .padding(.top, 5)
    }
}

struct PracticeCardView: View {
    var body: some View {
        VStack {
            PracticeTitleView()
            Spacer()
            
            Image("Card5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 110, alignment: .top)
                .cornerRadius(20)
            
        }
        .background(Color.green.opacity(0.5))
        .cornerRadius(20)
    }
}
