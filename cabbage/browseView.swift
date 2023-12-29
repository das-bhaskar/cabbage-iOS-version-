//
//  browseView.swift
//  cabbage
//
//  Created by Bhaskar Das on 26/12/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase  // Import the FirebaseDatabase module

struct browseView: View {
    
    @AppStorage("uid") var userID: String = ""
    @State private var isPostActive = false
    @State private var details: [String] = []

    private func fetchDataFromFirebase() {
        let detailsRef = Database.database().reference().child("detailsData")

        detailsRef.observeSingleEvent(of: .value) { snapshot in
            var detailsList: [String] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let value = snapshot.childSnapshot(forPath: "details").value as? String ?? ""
                    let emailValue = snapshot.childSnapshot(forPath: "email").value as? String ?? ""

                    // Concatenate details and email into a single string
                    let combinedValue = "\(value)\nemail: \(emailValue)"
                    detailsList.append(combinedValue)
                }
            }

            DispatchQueue.main.async {
                self.details = detailsList
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            
            VStack {
                if userID == "" {
                    authView()
                } else {
                    HStack {
                        Image(systemName: "checklist")
                            .foregroundColor(.black)
                            .bold()
                        Button(action: {
                            isPostActive = true
                        }) {
                            Text("Go to Post")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(.yellow))
                    .padding(.horizontal)
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background(NavigationLink("", destination: ContentView(), isActive: $isPostActive).opacity(0))
                    .navigationBarBackButtonHidden(true)
                    
                    
                    
                    
                    List(details, id: \.self) { detail in
                        Text(detail)
                    }
                    .listStyle(PlainListStyle()) 
                    .background(
                        RoundedRectangle(cornerRadius: 20) 
                            .fill(Color.black)
                    )
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    //load button
                    Button(action: {
                        fetchDataFromFirebase()
                    }) {
                        Text("Load Messages")
                            .foregroundColor(.black)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.yellow)
                            )
                            .padding(.horizontal)
                            .padding(.vertical)
                    }
                    
                    //signout button
                    Button(action: {
                        let firebaseAuth = Auth.auth()
                        do {
                            try firebaseAuth.signOut()
                            withAnimation {
                                userID = ""
                            }
                        } catch let signOutError as NSError {
                            print("Error signing out: \(signOutError)")
                        }
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.yellow)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .padding(.vertical)
                    }
                }
            }
        }
    }
}

struct browseView_Previews: PreviewProvider {
    static var previews: some View {
        browseView()
            .preferredColorScheme(.dark)
    }
}
