//
//  UserStore.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 12/31/21.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
	@Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
		didSet {
			UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
		}
	}
	@Published var showLogin: Bool = UserDefaults.standard.bool(forKey: "showLogin") {
		didSet {
			UserDefaults.standard.set(self.showLogin, forKey: "showLogin")
		}
	}
}
