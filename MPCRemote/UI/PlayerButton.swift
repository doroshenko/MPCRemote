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
    var longPressAction: (() -> Void)?
    var image: Image
    var scale: PlayerButtonScale

    var body: some View {
        Button(action: { }, label: {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: scale.imageSize, height: scale.imageSize)
                .onTapGesture {
                    self.action()
                }
                .onLongPressGesture(minimumDuration: 0.1) {
                    self.longPressAction?() ?? self.action()
                }
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
            return 20
        case .medium:
            return 33
        case .large:
            return 35
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
        static let radius: CGFloat = 6
        static let highlighted: CGFloat = 3
        static let normal: CGFloat = -6
    }

    static let border: CGFloat = 3
}

struct PlayerButton_Previews: PreviewProvider {
    static var buttons: some View {
        ZStack {
            Color(.systemBackground)
            VStack {
                ForEach(PlayerButtonScale.allCases, id: \.self) { scale in
                    PlayerButton(action: {
                        logDebug()
                    }, longPressAction: {
                        logDebug()
                    }, image: Image(systemName: "backward.fill"),
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
