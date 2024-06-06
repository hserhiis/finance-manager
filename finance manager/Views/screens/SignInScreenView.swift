import SwiftUI
import UIKit
import FirebaseAuth

struct SignInScreenView: View {
    @EnvironmentObject private var state: GlobalState
    @State var email: String = ""
    @State var password: String = ""
    @State var isValidEmail: Bool = true
    @State var isValidPassword: Bool = true
    
    func loadData() async {
        await state.fetchAmounts()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TextFieldCustomView(text: $email, placeholder: "Enter Email")
                    HStack {
                        if !isValidEmail {
                            Text("Email is incorrect")
                        }
                    }
                    .frame(height: 20)
                    TextFieldCustomView(text: $password, placeholder: "Password")
                    HStack {
                        if !isValidPassword {
                            Text("Password is incorrect")
                        }
                    }
                    .frame(height: 20)
                    VStack {
                        
                    }
                    .frame(height: 53)
                    HStack {
                        Text("Forget your password?")
                        NavigationLink(
                            destination: RestoreScreenView(),
                            label: {
                                Text("Restore password")
                            }
                        )
                        .navigationBarHidden(true)
                        .onTapGesture {
                            state.isPasswordRestored = false
                        }
                        
                    }
                    Spacer()
                    PrimaryButton(text: "Sign in")
                        .onTapGesture {
                            isValidEmail = getIsValidEmail(email)
                            isValidPassword = getIsValidPassword(password)
                            if isValidEmail && isValidPassword {
                                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                                    if let err = error {
                                        print(err)
                                    } else {
                                        if let userId = authResult?.user.uid {
                                            print(userId)
                                            state.userId = userId // Set the userId in GlobalState
                                            Task {
                                                await loadData() // Call loadData to fetch data
                                                state.isLoggedIn = true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    Spacer()
                    
                    
                    HStack {
                        Text("Don't have an account?")
                        NavigationLink(
                            destination: SignUpScreenView().navigationBarHidden(true),
                            label: {
                                Text("Sign up")
                            }
                        )
                        .navigationBarHidden(true)
                        
                    }
                }
            }
            .padding(.top, 180)
            .padding(.bottom, 80)
        }
        
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
            .environmentObject(GlobalState())
    }
}
