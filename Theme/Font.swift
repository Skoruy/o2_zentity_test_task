//
//  Font.swift
//  O2_test_task
//
//  Created by Sergii Skorokhod on 4/14/25.
//

import SwiftUI

struct FontStyle {
    let name: String
    let size: CGFloat
    let weight: Font.Weight
    let lineHeight: CGFloat
    let tracking: CGFloat
    
    var lineSpacing: CGFloat {
        max(0, lineHeight - size)
    }
    
    var font: Font {
        Font.custom(name, size: size).weight(weight)
    }
}

struct FontStyleModifier: ViewModifier {
    let style: FontStyle
    
    func body(content: Content) -> some View {
        content
            .font(style.font)
            .tracking(style.tracking)
            .lineSpacing(style.lineSpacing)
    }
}

extension View {
    func fontStyle(_ style: FontStyle) -> some View {
        self.modifier(FontStyleModifier(style: style))
    }
}

extension FontStyle {
    private static let interFamily = "Inter"
    
    /// Inter, 16pt, Medium (500), 22pt line height, 0.16 tracking
    static let labelM = FontStyle(
        name: interFamily,
        size: 16,
        weight: .medium,
        lineHeight: 22,
        tracking: 0.16
    )
    
    /// Inter, 14pt, Semibold (550), 17pt line height, 0.16 tracking
    static let labelS = FontStyle(
        name: interFamily,
        size: 14,
        weight: .semibold,
        lineHeight: 17,
        tracking: 0.16
    )
    
    /// Inter, 16pt, Regular (400), 22pt line height, 0.01 tracking
    static let bodyM = FontStyle(
        name: interFamily,
        size: 16,
        weight: .regular,
        lineHeight: 22,
        tracking: 0.01
    )
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices ullamcorper finibus. Etiam quis malesuada mauris. Mauris orci ante, bibendum a mi sit amet, ultricies venenatis leo. Cras porta enim non dui dignissim, at tincidunt lectus interdum. Aliquam eros turpis.")
            .fontStyle(.labelS)
        
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices ullamcorper finibus. Etiam quis malesuada mauris. Mauris orci ante, bibendum a mi sit amet, ultricies venenatis leo. Cras porta enim non dui dignissim, at tincidunt lectus interdum. Aliquam eros turpis.")
            .fontStyle(.labelM)
        
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultrices ullamcorper finibus. Etiam quis malesuada mauris. Mauris orci ante, bibendum a mi sit amet, ultricies venenatis leo. Cras porta enim non dui dignissim, at tincidunt lectus interdum. Aliquam eros turpis.")
            .fontStyle(.bodyM)
    }
    .padding()
}
