//
//  RingView.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 6/27/21.
//

import SwiftUI

struct RingView: View {
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    var width: CGFloat = 44
    var height: CGFloat = 44
    var percent: CGFloat = 44
    @Binding var show: Bool
    
    var body: some View {
        let multiplier = width / 44
        let progress = 1 - (percent / 100)
        
       return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1),
                              style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)
                
            Circle()
                .trim(from: show ? progress : 1, to: 1.0)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1, y: 0, z: 0)
                )
                .frame(width: width, height: height)
                .shadow(color: Color(color2), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
                
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
                .onTapGesture {
                    show.toggle()
                }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
