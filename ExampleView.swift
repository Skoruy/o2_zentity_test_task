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
    @State private var confirmPassword = ""
    @State var isContinueButtonEnabled = false
    
    func validateForm() {
        isContinueButtonEnabled = !username.isEmpty && PasswordInputView.isPasswordValid(password) && confirmPassword == password
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: .l) {
                    InputView(
                        title: "Username",
                        subtitle: "(Required)",
                        placeholder: "Enter your username or email",
                        text: $username,
                        contentType: .username
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
                        password: $password,
                        contentType: .password
                    ) { _ in
                        validateForm()
                    }
                    
                    PasswordInputView(
                        title: "Confirm Password",
                        subtitle: "(Required)",
                        placeholder: "Enter your password again",
                        password: $confirmPassword,
                        contentType: .password,
                        onValueChanged: { _ in
                            validateForm()
                        }, additionalValidation: { newValue in
                            if newValue != password { return "Passwords do not match" }
                            return nil
                        }
                    )
                    
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
            }.navigationTitle("Example")
        }
    }
    
    private func handleLogin() {
        // Do any actions here
    }
}

#Preview {
    ExampleView()
}
