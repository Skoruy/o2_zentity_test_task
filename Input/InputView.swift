//
//  InputView.swift
//  O2_test_task
//
//  Created by Sergii Skorokhod on 4/14/25.
//

import SwiftUI

struct InputView<TrailingContent: View>: View {
    let title: String
    var subtitle: String? = nil
    let placeholder: String
    @Binding var text: String
    var isSecure = false
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .none
    var contentType: UITextContentType? = nil
    var disableAutocorrection = false
    var onValueChanged: ((String?) -> Void)? = nil
    var validation: ((String) -> String?)? = nil
    
    @ViewBuilder var trailingContent: () -> TrailingContent
    
    @State private var validationMessage: String? = nil
    @FocusState private var isInputFocused: Bool
    
    init(
        title: String,
        subtitle: String? = nil,
        placeholder: String,
        text: Binding<String>,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default,
        autocapitalization: UITextAutocapitalizationType = .none,
        contentType: UITextContentType? = nil,
        disableAutocorrection: Bool = false,
        onValueChanged: ((String?) -> Void)? = nil,
        validation: ((String) -> String?)? = nil
    ) where TrailingContent == EmptyView {
        self.init(
            title: title,
            subtitle: subtitle,
            placeholder: placeholder,
            text: text,
            isSecure: isSecure,
            keyboardType: keyboardType,
            autocapitalization: autocapitalization,
            contentType: contentType,
            disableAutocorrection: disableAutocorrection,
            onValueChanged: onValueChanged,
            validation: validation,
            trailingContent: { EmptyView() }
        )
    }
    
    init(
        title: String,
        subtitle: String? = nil,
        placeholder: String,
        text: Binding<String>,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default,
        autocapitalization: UITextAutocapitalizationType = .none,
        contentType: UITextContentType? = nil,
        disableAutocorrection: Bool = false,
        onValueChanged: ((String?) -> Void)? = nil,
        validation: ((String) -> String?)? = nil,
        @ViewBuilder trailingContent: @escaping () -> TrailingContent
    ) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.contentType = contentType
        self.disableAutocorrection = disableAutocorrection
        self.onValueChanged = onValueChanged
        self.validation = validation
        self.trailingContent = trailingContent
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .xs) {
            HStack(spacing: .xs) {
                Text(title)
                    .fontStyle(.labelM)
                    .foregroundColor(displayError ? .content.neutralDanger : .content.neutralHigh)
                
                if let subtitle {
                    Text(subtitle)
                        .fontStyle(.labelS)
                        .foregroundColor(.content.neutralLow)
                }
            }
            
            HStack(spacing: .xs) {
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text, prompt: Text(placeholder).foregroundColor(.content.neutralLow))
                    } else {
                        TextField(placeholder, text: $text, prompt: Text(placeholder).foregroundColor(.content.neutralLow))
                    }
                }
                .textContentType(contentType)
                .foregroundColor(.content.neutralHigh)
                .keyboardType(keyboardType)
                .autocapitalization(autocapitalization)
                .disableAutocorrection(disableAutocorrection)
                .fontStyle(.bodyM)
                .focused($isInputFocused)
                
                trailingContent()
                    .foregroundColor(.content.neutralLow)
            }
            .padding(.s)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: .inputCornerRadius)
                    .fill(Color.surface.xLow)
            )
            .overlay(
                RoundedRectangle(cornerRadius: .inputCornerRadius)
                    .stroke(
                        displayError ? Color.surface.danger : Color.surface.xHigh,
                        lineWidth: .inputBorderWidth
                    )
            )
            .toolbar {
                if showToolbar && isInputFocused {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") { isInputFocused = false }
                            .tint(.surface.brand)
                    }
                }
            }
            .onChange(of: text) { _, newValue in
                defer { onValueChanged?(newValue) }
                guard let validation else { return }
                
                if newValue.isEmpty {
                    validationMessage = nil
                    return
                }
                
                validationMessage = validation(newValue)
            }
            
            // Not in task, but I think it's important to have ability to tell user what is exactly wrong
            if displayError, let validationMessage {
                Text(validationMessage)
                    .font(.caption)
                    .foregroundColor(.content.neutralDanger)
                    .transition(.opacity.animation(.easeIn))
            }
        }
        .animation(.default, value: validationMessage != nil)
    }
    
    private var displayError: Bool {
        validationMessage != nil && validationMessage?.count ?? 0 > 0
    }
    
    private var showToolbar: Bool {
        [.numberPad, .phonePad, .decimalPad].contains(keyboardType)
    }
}

struct InputView_Previews: PreviewProvider {
    @State static var text1: String = ""
    @State static var text2: String = ""
    @State static var text3: String = ""
    
    static var previews: some View {
        VStack(spacing: 16) {
            InputView(
                title: "User name",
                placeholder: "testUser",
                text: $text1
            )
            
            InputView(
                title: "Amount",
                subtitle: "Optional",
                placeholder: "Enter purchase amount",
                text: $text2,
                keyboardType: .numberPad
            )
            
            InputView(
                title: "Email",
                placeholder: "vas@email.sk",
                text: $text3,
                keyboardType: .emailAddress
            )
        }
        .padding()
    }
}
