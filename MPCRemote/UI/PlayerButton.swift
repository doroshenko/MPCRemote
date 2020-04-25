//
//  ViewStyle.swift
//  MPCRemote
//
//  Created by doroshenko on 25.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerButtonStyle: ButtonStyle {
    var padding = Constants.Padding.small

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(padding)
            .contentShape(Circle())
            .foregroundColor(configuration.isPressed ? Color.buttonIconHighlight : Color.buttonIcon)
            .background(
                PlayerButtonBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
            .animation(nil)
    }
}

struct PlayerButtonBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S

    var body: some View {
        shape
            .fill(gradient)
            .overlay(shape.stroke(LinearGradient.buttonHighlight, lineWidth: Constants.border))
            .modifier(PlayerButtonShadow(isHighlighted: isHighlighted))
    }

    private var gradient: LinearGradient {
        isHighlighted ? .buttonHighlightReversed : .buttonMain
    }
}

struct PlayerButtonShadow: ViewModifier {
    var isHighlighted: Bool

    private var size: CGFloat {
        isHighlighted ? Constants.Shadow.highlighted : Constants.Shadow.normal
    }

    func body(content: Content) -> some View {
        content
            .shadow(color: Color.buttonGradientStart, radius: Constants.Shadow.radius, x: size, y: size)
            .shadow(color: Color.buttonGradientEnd, radius: Constants.Shadow.radius, x: -size, y: -size)
    }
}

private struct Constants {
    enum Padding {
        static let small: CGFloat = 30
        static let large: CGFloat = 50
    }

    enum Shadow {
        static let radius: CGFloat = 10
        static let highlighted: CGFloat = 5
        static let normal: CGFloat = -10
    }

    static let border: CGFloat = 4
}

struct PlayerButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color(.systemBackground)
                Button(action: {
                    logInfo()
                }, label: {
                    Image(systemName: "play.fill")
                })
                .buttonStyle(PlayerButtonStyle())
            }
            .environment(\.colorScheme, .light)

            ZStack {
                Color(.systemBackground)
                Button(action: {
                    logInfo()
                }, label: {
                    Image(systemName: "play.fill")
                })
                .buttonStyle(PlayerButtonStyle())
            }
            .environment(\.colorScheme, .dark)
        }
    }
}
