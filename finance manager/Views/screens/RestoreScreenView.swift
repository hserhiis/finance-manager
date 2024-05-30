//
//  RestoreScreenView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-25.
//

import SwiftUI
import FirebaseAuth

struct RestoreScreenView: View {
    @EnvironmentObject var state: GlobalState
    private let height = UIScreen.main.bounds.height - 180
    @State private var email: String = ""
    @State private var isEmailCorrect: Bool = true
    
    var restoreButton: some View {
        PrimaryButton(text: "Restore")
        .navigationBarHidden(true)
        .zIndex(99)
        .padding(.top, height)
        .onTapGesture {
            isEmailCorrect = getIsValidEmail(value: email)
            if isEmailCorrect {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let err = error {
                        print(err)
                    } else {
                        state.isPasswordRestored = true
                    }
                }
            }
        }
    }
    
    var loginButton: some View {
        NavigationLink(
            destination: SignInScreenView().navigationBarHidden(true),
            label: {
                PrimaryButton(text: "Log in")
            }
        )
        .navigationBarHidden(true)
        .padding(.top, height)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if state.isPasswordRestored {
                    VStack {
                        Text("Chek your email and log in after the password is changed")
                    }
                } else {
                    VStack {
                        Text("Enter your email")
                        TextFieldCustomView(text: $email, placeholder: "Enter Email")
                    }
                    
                    HStack {
                        if !isEmailCorrect {
                            Text("Email is incorrect")
                        }
                    }
                    .frame(height: 20)
                }
                if state.isPasswordRestored {
                    loginButton
                } else {
                    restoreButton
                }
            }
        }
    }
}

#Preview {
    RestoreScreenView()
}
