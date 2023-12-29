//
//  loginPage.swift
//  cabbage
//
//  Created by Bhaskar Das on 24/12/23.
//

import SwiftUI
import FirebaseAuth
struct loginPage: View {
    
    @Binding var currentShowingView: String
    
    @State private var email: String=""
    @State private var password: String = ""
    @AppStorage("uid") var userID:  String = ""
    
    private func isValidPassword(_ password: String) -> Bool {
        //  password criteria
        let minLength = 8
        let containsUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let containsLowercase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let containsDigit = password.rangeOfCharacter(from: .decimalDigits) != nil
        let containsSpecialCharacter = password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$&*")) != nil

        // Check all criteria
        return password.count >= minLength &&
               containsUppercase &&
               containsLowercase &&
               containsDigit &&
               containsSpecialCharacter
    }

    
    
    var body: some View {
        ZStack{
            Color(.black).edgesIgnoringSafeArea(.all)
            VStack {
                HStack{
                    Text("Welcome Back!")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                     
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                HStack{
                    Image(systemName: "mail")
                        .foregroundColor(.yellow)
                    TextField("Email",text: $email)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if(email.count != 0){
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                    }
                    
                    
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color(.white.opacity(0.6)))
                )
                .padding()
                
                HStack{
                    Image(systemName: "lock")
                        .foregroundColor(.yellow)
                    SecureField("Password",text: $password)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if (password.count != 0){
                        Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(isValidPassword(password) ? .green : .red)
                    }
                }
                
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color(.white.opacity(0.6)))
                )
                .padding()
                
                Button(action:{
                    withAnimation{
                        self.currentShowingView = "signup"
                    }
                }){
                    Text("Don't have an account?")
                        .foregroundColor(.yellow.opacity(0.8))
                }
                
                Spacer()
                
//                Image("artboardCabbage")
//                    .resizable()
//                    .frame(width: 120,height: 120)
                
                
                Button{
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error{
                            print(error)
                            return
                        }
                        if let authResult = authResult{
                            print(authResult.user.uid)
                            withAnimation{
                                userID = authResult.user.uid
                            }
                        }
                    }
                }label:{
                    Text("Sign In")
                        .foregroundColor(.black)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.yellow)
                        )
                        .padding(.horizontal)
                        .padding(.vertical)
                        .padding(.vertical)
                        .padding(.bottom)
                }
               
            }
            
        }
    }
}


struct loginPage_Previews: PreviewProvider {
    @State static var currentShowingView: String = "signup"
    
    static var previews: some View {
        loginPage(currentShowingView: $currentShowingView)
            .preferredColorScheme(.dark)
    }
}


