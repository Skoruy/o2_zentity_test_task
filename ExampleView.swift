//
//  ExampleView.swift
//  O2_test_task
//
//  Created by Sergii Skorokhod on 4/14/25.
//


import SwiftUI

struct ExampleView: View {
    @State private var username = ""
    @State private var id = ""
    @State private var password = ""
    @State var isContinueButtonEnabled = false
    
    func validateForm() {
        isContinueButtonEnabled = !username.isEmpty && PasswordInputView.isPasswordValid(password)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: .l) {
                InputView(
                    title: "Username",
                    subtitle: "(Required)",
                    placeholder: "Enter your username or email",
                    text: $username
                ) { _ in
                    validateForm()
                }
                
                InputView(
                    title: "O2 id",
                    subtitle: "(Optional)",
                    placeholder: "Enter your O2 id",
                    text: $id,
                    keyboardType: .numberPad
                ) { _ in
                    validateForm()
                }
                
                PasswordInputView(
                    title: "Password",
                    subtitle: "(Required)",
                    placeholder: "Enter your password",
                    password: $password
                ) { _ in
                    validateForm()
                }
                
                Spacer()
                
                Button {
                    handleLogin()
                } label: {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding(.l)
                        .background(!isContinueButtonEnabled ? Color.surface.xHigh : Color.surface.brand)
                        .foregroundColor(.content.neutralLow)
                        .cornerRadius(.inputCornerRadius)
                }
                .disabled(!isContinueButtonEnabled)
                .padding(.bottom, .m)
            }
            .padding(.l)
            .navigationTitle("Example")
        }
    }
    
    private func handleLogin() {
        // Do any actions here
    }
}

#Preview {
    ExampleView()
}
