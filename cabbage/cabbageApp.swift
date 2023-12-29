//
//  cabbageApp.swift
//  cabbage
//
//  Created by Bhaskar Das on 24/12/23.
//

import SwiftUI
import FirebaseCore

@main
struct cabbageApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
