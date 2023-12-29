import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase


struct ContentView: View {
    @State private var details: String = ""
    @State private var emailid: String = ""
    @AppStorage("uid") var userID:  String = ""
    @State private var isBrowseActive = false
    
    
    // Define database reference
       var detailsRef: DatabaseReference!

       init() {
           detailsRef = Database.database().reference().child("detailsData")
       }
    
    private func postDetails() {
        // ... Firebase reference setup
        
        // Get details and email
        let detailsValue = details
        let emailValue = emailid

        // Create a dictionary for the data to be posted
        let postData: [String: Any] = [
            "details": detailsValue,
            "email": emailValue
        ]

        // Push data to Firebase
        detailsRef.childByAutoId().setValue(postData) { error, _ in
            if let error = error {
                print("Error posting details: \(error)")
            } else {
                print("Details posted successfully!")
            }
        }
    }


    var body: some View {
        
    
        NavigationView {
            ZStack {
                Color(.black).edgesIgnoringSafeArea(.all)

                VStack {
                    if userID == "" {
                        authView()
                    } else {
                        
                        
                        // Browse button
                        
                        HStack {
                            Button(action: {
                                isBrowseActive = true
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                                    .bold()
                                Text("Browse")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundColor(.yellow))
                            .padding(.horizontal)
                            .padding(.vertical)
                            .padding(.horizontal)
                            .background(NavigationLink("", destination: browseView(), isActive: $isBrowseActive).opacity(0))
                            .navigationBarBackButtonHidden(true)
                        }

                        
                        
                        // Text information
                        HStack {
                            Text("Find Research Partners!")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.yellow)
                            Spacer()
                        }
                        .padding()

                        HStack {
                            Text("Enter details of your field of interest for research or study partner.")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding()

                        // Details input
                        TextField("", text: $details)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                            .padding(.vertical, 40)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray)
                                    .foregroundColor(.black)
                            )
                            .padding(.horizontal)
                            .padding(.bottom)

                        // Email
                        HStack {
                            Text("Email ID")
                                .bold()
                                .font(.title3)
                                .foregroundColor(.yellow)
                            Spacer()
                        }
                        .padding()

                        TextField("", text: $emailid)
                            .foregroundColor(.black)
                            .font(.title3)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray)
                                    .foregroundColor(.black)
                            )
                            .padding(.horizontal)
                            .padding(.bottom)
                        
                        

                        // Load button
                        Button(action: {
                            postDetails()
                        }) {
                            Text("Post")
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
                                .padding(.bottom)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
