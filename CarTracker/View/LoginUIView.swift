//
//  LoginUIView.swift
//  CarTracker
//
//  Created by Mádi István on 2021. 12. 11..
//

import SwiftUI
import Firebase

struct LoginUIView: View {
    
    @State private var showingPopover = false
    @State private var errorMessage = "An error occurred"
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            
            Image("car")
                .resizable()
                .frame(width: 200, height: 200)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color(UIColor.lightGray))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(UIColor.lightGray))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
            
            
            Button(action: { login() }) {
                HStack {
                    Spacer()
                    Text("Sign in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                
                .background(Color.green)
                .cornerRadius(15.0)
            }
            
            Button(action: { register() }) {
                HStack {
                    Spacer()
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .background(Color.green)
                .cornerRadius(15.0)
            }.padding(.top)
        }
        .padding()
        .alert(errorMessage,isPresented: $showingPopover) {
            Button("Try Again"){
                email = ""
                password = ""
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                
                if let x = error {
                    let err = x as NSError
                    errorMessageHelper(error: err)
                }
                showingPopover = true
            } else {
                print("success signing in")
                UserSettings.shared.loggedIn.toggle()
            }
        }
    }
    func register(){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error ) in
            if error != nil{
                print(error?.localizedDescription ?? "")
                if let x = error {
                    let err = x as NSError
                    errorMessageHelper(error: err)
                }
                showingPopover = true
            }
            else{
                print("success register")
                login()
            }
        }
    }
    func errorMessageHelper(error: NSError){
        switch error.code {
        case AuthErrorCode.wrongPassword.rawValue:
            errorMessage = "Wrong password!"
        case AuthErrorCode.invalidEmail.rawValue:
            errorMessage = "Invalid email format!"
        case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
            errorMessage = "the account already exists"
        default:
            errorMessage = "An error occurred"
        }
    }
}

struct LoginUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUIView()
    }
}
