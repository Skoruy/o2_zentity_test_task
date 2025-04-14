//
//  Color.swift
//  O2_test_task
//
//  Created by Sergii Skorokhod on 4/14/25.
//

import SwiftUI

// Prefer color literals over hex init for more convenient each day development
extension Color {
    struct surface {
        ///#8C8C9A (core/gray/500)
        static let xHigh = Color(#colorLiteral(red: 0.5490180254, green: 0.5490208864, blue: 0.6089766026, alpha: 1))
        ///#FFFFFF (core/gray/00)
        static let xLow = Color(#colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1))
        ///#0050FF (core/blue/500)
        static let brand = Color(#colorLiteral(red: 0, green: 0.3201515675, blue: 1, alpha: 1))
        ///#DC2828 (core/red/600)
        static let danger = Color(#colorLiteral(red: 0.862745098, green: 0.1568627451, blue: 0.1568627451, alpha: 1))
        ///#FFDCDC (core/red/100)
        static let dangerVariant = Color(#colorLiteral(red: 1, green: 0.8563196063, blue: 0.859757185, alpha: 1))
        ///#A56315 (core/yellow/700)
        static let warning = Color( #colorLiteral(red: 0.6892639399, green: 0.3721567094, blue: 0, alpha: 1))
        ///#FAF1B6 (core/yellow/100)
        static let warningVariant = Color(#colorLiteral(red: 0.988109529, green: 0.9435697198, blue: 0.6842084527, alpha: 1))
    }
    
    struct content {
        /// #2C2C31 (core/gray/950)
        static let neutralHigh = Color(#colorLiteral(red: 0.1725484729, green: 0.1725494564, blue: 0.1939679086, alpha: 1))
        /// #8C8C9A (core/gray/500)
        static let neutralMedium = Color(#colorLiteral(red: 0.5490180254, green: 0.5490208864, blue: 0.6089766026, alpha: 1))
        /// #C9C9CE (core/gray/300)
        static let neutralLow = Color(#colorLiteral(red: 0.7882347703, green: 0.788235724, blue: 0.8097358942, alpha: 1))
        /// #DC2828 (core/red/600)
        static let neutralDanger = Color(#colorLiteral(red: 0.9414550662, green: 0, blue: 0.08304477483, alpha: 1))
        /// #D32F2F (core/red/700)
        static let neutralWarning = Color(#colorLiteral(red: 0.9021017551, green: 0.02846865356, blue: 0.1343295872, alpha: 1))
    }
    
    struct state {
        /// #1A1A1A0F, 6% (core/alpha/dim/50)
        static let defaultHover = Color(#colorLiteral(red: 0.9450981021, green: 0.9450981021, blue: 0.9450979829, alpha: 1))
        /// #1A1A1ACC, 80% (core/alpha/dim/800)
        static let defaultFocus = Color(#colorLiteral(red: 0.2823530138, green: 0.2823530138, blue: 0.2823530138, alpha: 1))
    }
}

// MARK: - Example Usage
private struct ColorLibraryExampleView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Surface Colors")
                    .font(.headline)
                VStack(spacing: 8) {
                    colorRow(name: "xHigh", color: .surface.xHigh)
                    colorRow(name: "xLow", color: .surface.xLow, border: true)
                    colorRow(name: "brand", color: .surface.brand)
                    colorRow(name: "danger", color: .surface.danger)
                    colorRow(name: "dangerVariant", color: .surface.dangerVariant)
                    colorRow(name: "warningVariant", color: .surface.warningVariant)
                }
                
                Text("Content Colors")
                    .font(.headline)
                VStack(spacing: 8) {
                    colorRow(name: "onNeutralXxHigh", color: .content.neutralHigh)
                    colorRow(name: "onNeutralMedium", color: .content.neutralMedium)
                    colorRow(name: "neutralLow", color: .content.neutralLow)
                    colorRow(name: "neutralDanger", color: .content.neutralDanger)
                    colorRow(name: "neutralWarning", color: .content.neutralWarning)
                }
                
                Text("State Colors")
                    .font(.headline)
                VStack(spacing: 8) {
                    colorRow(name: "defaultHover", color: .state.defaultHover)
                    colorRow(name: "defaultFocus", color: .state.defaultFocus)
                }
            }
        }
        .padding()
    }
    
    func colorRow(name: String, color: Color, border: Bool = false) -> some View {
        HStack(spacing: 8) {
            Rectangle().fill(color).border(Color.surface.xHigh, width: border ? 1 : 0).frame(width: 44, height: 44)
            Text(name)
            Spacer()
        }
    }
}

#Preview {
    ColorLibraryExampleView()
        .background(.white)
}
