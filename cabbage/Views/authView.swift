//
//  authView.swift
//  cabbage
//
//  Created by Bhaskar Das on 25/12/23.
//

import SwiftUI

struct authView: View {
    @State private var currentViewShowing : String = "login"
    var body: some View {
        
        if currentViewShowing == "login"{
            loginPage(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.dark)
        }
        else{
            signupPage(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .bottom))
        }
        
        
    }
}

#Preview {
    authView()
}
