//
//  DesignCodeProjectApp.swift
//  DesignCodeProject
//
//  Created by Ociel Lerma on 5/30/21.
//

import SwiftUI
import Firebase

final class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		FirebaseApp.configure()
		return true
	}
}

@main
struct DesignCodeProjectApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
			LoginView()
        }
    }
}
