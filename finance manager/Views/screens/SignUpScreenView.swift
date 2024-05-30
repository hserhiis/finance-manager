//
//  SignUpScreenView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-11.

import FirebaseCore
import FirebaseAuth
//

import SwiftUI

struct SignUpScreenView: View {
    @EnvironmentObject private var state: GlobalState
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirm: String = ""
    @State var isValidEmail: Bool = true
    @State var isValidPassword: Bool = true
    @State var isValidConfirmedPassword: Bool = true
    
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
                    TextFieldCustomView(text: $passwordConfirm, placeholder: "Confirm Password")
                    HStack {
                        if !isValidConfirmedPassword {
                            Text("Confirmed password is incorrect")
                        }
                    }
                    .frame(height: 20)
                    Spacer()
                    PrimaryButton(text: "Sign up")
                        .onTapGesture {
                            isValidEmail = getIsValidEmail(value: email)
                            isValidPassword = getIsValidPassword(value: password)
                            isValidConfirmedPassword = getIsValidConfirmedPassword(password: password, confirmedPassword: passwordConfirm)
                            if isValidEmail && isValidPassword && isValidConfirmedPassword {
                                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                    if let err = error {
                                        print(err)
                                    } else {
                                        // User creation successful
                                        if let userId = authResult?.user.uid {
                                            // Set the user ID in the GlobalState
                                            state.userId = userId
                                            
                                            // Create user data in Firestore
                                            Task {
                                                await state.createUserData(userId: userId)
                                            }
                                            
                                            // Set the isSignedUp flag to true
                                            state.isSignedUp = true
                                        }
                                    }
                                }
                            }
                        }

                    Spacer()
                    Text("---- OR ----")
                    Spacer()
                    SocialButton(icon: .google, text: "Sign up with google")
                    SocialButton(icon: .apple, text: "Sign up with apple")
                    HStack {
                        Text("Already have an account?")
                        NavigationLink(
                            destination: SignInScreenView().navigationBarHidden(true),
                            label: {
                                Text("Sign in")
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

#Preview {
    SignUpScreenView()
}
