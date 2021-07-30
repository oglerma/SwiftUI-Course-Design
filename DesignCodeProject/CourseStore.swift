//
//  CourseStore.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 7/30/21.
//

import SwiftUI
import Contentful


let client = Client(spaceId: "spaceId", accessToken: "accessToken")

func getArray() {
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        print(result)
    }
}
