//
//  DataStore.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 7/29/21.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    func getPosts() {
        Api().getPosts { posts in
            self.posts = posts
        }
    }
}
