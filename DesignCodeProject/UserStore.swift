//
//  UserStore.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 12/31/21.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
	@Published var isLogged = false
	@Published var showLogin = false
}
