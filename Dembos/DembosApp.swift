//
//  DembosApp.swift
//  Dembos
//
//  Created by user231685 on 11/12/22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct DembosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
          NavigationView {
              
              if let _ = authenticationViewModel.user{
                  HomeView(authenticationViewModel: authenticationViewModel)
              } else {
                  OnboardingView(authenticationViewModel: authenticationViewModel)
              }
          }
        }
      }
}
