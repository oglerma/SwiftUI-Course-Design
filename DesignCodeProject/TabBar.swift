//
//  TabBar.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 6/25/21.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home()
				.tabItem {
                    Image(systemName: "play.circle.fill")
                    Text("Home")
                }
            
            CourseList()
				.tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Courses")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
			.environmentObject(UserStore())
    }
}
