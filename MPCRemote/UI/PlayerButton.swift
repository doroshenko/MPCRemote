//
//  ViewStyle.swift
//  MPCRemote
//
//  Created by doroshenko on 25.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerButton: View {
    var action: () -> Void
    var image: Image
    var scale: PlayerButtonScale

    var body: some View {
        Button(action: action, label: {
            image
                .resizable()
                .frame(width: scale.imageSize, height: scale.imageSize)
        })
            .buttonStyle(PlayerButtonStyle(padding: scale.padding))
    }
}

struct PlayerButtonStyle: ButtonStyle {
    var padding: CGFloat

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

enum PlayerButtonScale: CaseIterable {
    case small
    case medium
    case large

    var imageSize: CGFloat {
        switch self {
        case .small:
            return 15
        case .medium:
            return 20
        case .large:
            return 30
        }
    }

    var padding: CGFloat {
        switch self {
        case .small:
            return 20
        case .medium:
            return 30
        case .large:
            return 40
        }
    }
}

private struct Constants {
    enum Shadow {
        static let radius: CGFloat = 10
        static let highlighted: CGFloat = 5
        static let normal: CGFloat = -10
    }

    static let border: CGFloat = 4
}

struct PlayerButton_Previews: PreviewProvider {
    static var buttons: some View {
        ZStack {
            Color(.systemBackground)
            VStack {
                ForEach(PlayerButtonScale.allCases, id: \.self) { scale in
                    PlayerButton(action: {
                        logDebug()
                    }, image: Image(systemName: "play.fill"),
                       scale: scale)
                }
            }
        }
    }

    static var previews: some View {
        Group {
            ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
                buttons.environment(\.colorScheme, scheme)
            }
        }
    }
}
