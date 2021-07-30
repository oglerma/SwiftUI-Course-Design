//
//  Data.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 7/29/21.
//

import SwiftUI

struct Post: Codable, Identifiable {
    var id = UUID()
    var title: String
    var body: String
}


class API {
    func getPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            do {
                let response = try JSONDecoder().decode([Post].self, from: data!)
                print(response)
            } catch {
                
            }
        }.resume()
        
    }
}
