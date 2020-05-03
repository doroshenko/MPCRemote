//
//  PreviewStyle.swift
//  MPCRemote
//
//  Created by doroshenko on 03.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

enum PreviewStyle {
    case compact
    case full
}

extension View {
    func previewStyle(_ style: PreviewStyle) -> some View {
        Group {
            if style == .compact {
                compactView()
            } else if style == .full {
                fullView()
            }
        }
    }

    private func compactView() -> some View {
        modifier(PreviewStyleCompact())
    }

    private func fullView() -> some View {
        modifier(PreviewStyleFull())
    }
}

struct PreviewStyleCompact: ViewModifier {

    func body(content: Content) -> some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            content
                .background(Color(.systemBackground))
                .environment(\.colorScheme, scheme)
                .previewLayout(.sizeThatFits)
        }
    }
}

struct PreviewStyleFull: ViewModifier {

    func body(content: Content) -> some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            content
                .background(Color(.systemBackground))
                .environment(\.colorScheme, scheme)
        }
    }
}
