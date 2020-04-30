//
//  View+ScreenWidth.swift
//  MPCRemote
//
//  Created by doroshenko on 30.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

extension View {
    func screenWidth(padding: CGFloat = 0) -> some View {
        self.frame(maxWidth: UIScreen.main.bounds.width - padding)
    }
}
