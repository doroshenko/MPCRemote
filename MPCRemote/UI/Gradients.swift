//
//  Gradients.swift
//  MPCRemote
//
//  Created by doroshenko on 26.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

extension LinearGradient {
    static let buttonMain = LinearGradient(.buttonGradientStart, .buttonGradientEnd)
    static let buttonHighlight = LinearGradient(.buttonHighlightStart, .buttonHighlightEnd)
    static let buttonHighlightReversed = LinearGradient(.buttonHighlightEnd, .buttonHighlightStart)
}

private extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
