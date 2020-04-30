//
//  Gradients.swift
//  MPCRemote
//
//  Created by doroshenko on 26.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

extension LinearGradient {
    static let shadow = LinearGradient(.shadowStart, .shadowEnd)
    static let accent = LinearGradient(.accentStart, .accentEnd)
    static let accentReversed = LinearGradient(.accentEnd, .accentStart)
}

private extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
