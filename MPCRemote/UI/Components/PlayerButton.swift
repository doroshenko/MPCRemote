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
                .frame(minWidth: scale.minImageSize, idealWidth: scale.maxImageSize, maxWidth: scale.maxImageSize, minHeight: scale.minImageSize, idealHeight: scale.maxImageSize, maxHeight: scale.maxImageSize)
                .onTapGesture {
                    self.action()
                }
                .onLongPressGesture(minimumDuration: 0.1) {
                    self.longPressAction?() ?? self.action()
                }
        })
            .buttonStyle(PlayerButtonStyle(padding: scale.padding))
            .aspectRatio(contentMode: .fit)
    }
}

struct PlayerButtonStyle: ButtonStyle {
    var padding: CGFloat

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(padding)
            .contentShape(Circle())
            .foregroundColor(configuration.isPressed ? Color.mainAccent : Color.main)
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
            .overlay(shape.stroke(LinearGradient.accent, lineWidth: Constants.border))
            .modifier(PlayerButtonShadow(isHighlighted: isHighlighted))
    }

    private var gradient: LinearGradient {
        isHighlighted ? .accentReversed : .shadow
    }
}

struct PlayerButtonShadow: ViewModifier {
    var isHighlighted: Bool

    private var size: CGFloat {
        isHighlighted ? Constants.Shadow.highlighted : Constants.Shadow.normal
    }

    func body(content: Content) -> some View {
        content
            .shadow(color: Color.shadowStart, radius: Constants.Shadow.radius, x: size, y: size)
            .shadow(color: Color.shadowEnd, radius: Constants.Shadow.radius, x: -size, y: -size)
    }
}

enum PlayerButtonScale: CaseIterable {
    case navigation
    case control
    case play

    var minImageSize: CGFloat {
        switch self {
        case .navigation:
            return 15
        case .control:
            return 15
        case .play:
            return 30
        }
    }

    var maxImageSize: CGFloat {
        switch self {
        case .navigation:
            return 30
        case .control:
            return 20
        case .play:
            return 50
        }
    }

    var padding: CGFloat {
        switch self {
        case .navigation:
            return 15
        case .control:
            return 15
        case .play:
            return 20
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
    static var previews: some View {
        VStack {
            ForEach(PlayerButtonScale.allCases, id: \.self) { scale in
                PlayerButton(action: {
                    logDebug(domain: .ui)
                }, longPressAction: {
                    logDebug(domain: .ui)
                }, image: Image(systemName: "backward.fill"),
                   scale: scale)
            }
        }
        .previewStyle(.compact)
    }
}
