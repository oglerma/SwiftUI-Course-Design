//
//  CourseDetail.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 7/28/21.
//

import SwiftUI

struct CourseDetail: View {
    var course: Course
    @Binding var show: Bool
    var body: some View {
        Text("Hello World")
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(course: courseData[0], show: .constant(true))
    }
}
