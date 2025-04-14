//
//  PasswordInputView.swift
//  O2_test_task
//
//  Created by Sergii Skorokhod on 4/14/25.
//

import SwiftUI

private struct PasswordRule: Identifiable {
    let id = UUID()
    let text: String
    let validation: (String) -> Bool
}

struct PasswordInputView: View {
    let title: String
    var subtitle: String? = nil
    let placeholder: String
    @Binding var password: String
    @State private var isPasswordVisible = false
    var onValueChanged: ((String?) -> Void)? = nil
    
    // Prefer simple set of rules over some validation regex for more control and easy future changes
    private static let rules: [PasswordRule] = [
        PasswordRule(text: "Min 8 symbols") { $0.count >= 8 },
        PasswordRule(text: "At least one large letter") {
            $0.rangeOfCharacter(from: .uppercaseLetters) != nil
        },
        PasswordRule(text: "At least one digit") {
            $0.rangeOfCharacter(from: .decimalDigits) != nil
        },
        PasswordRule(text: "At least one special symbol ( ? = # / % )") {
            $0.rangeOfCharacter(from: CharacterSet(charactersIn: "?=#/%")) != nil
        },
    ]
    
    var body: some View {
        InputView(
            title: title,
            subtitle: subtitle,
            placeholder: placeholder,
            text: $password,
            isSecure: !isPasswordVisible,
            keyboardType: .asciiCapable,
            disableAutocorrection: true,
            onValueChanged: onValueChanged,
            validation: { newValue in
                return Self.validatePassword(newValue)
            }
        )
    }
    
    private static func validatePassword(_ currentPassword: String) -> String? {
        var validationErrors: [String] = []
        for rule in Self.rules {
            
            let valid = rule.validation(currentPassword)
            if !valid {
                validationErrors.append(rule.text)
            }
        }
        return validationErrors.isEmpty ? nil : validationErrors.joined(separator: ", ")
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        validatePassword(password) == nil
    }
}

struct PasswordInputView_Previews: PreviewProvider {
    @State static var password: String = ""
    
    static var previews: some View {
        PasswordInputView(
            title: "Password",
            subtitle: "(Required)",
            placeholder: "Enter your password", password: $password
        )
        .padding()
    }
}
