//
//  UpdateStore.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 6/25/21.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
