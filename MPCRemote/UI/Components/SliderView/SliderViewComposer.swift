//
//  SliderViewComposer.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct SliderViewComposer: ComposerType {
    private let parent: Composer

    init(parent: Composer) {
        self.parent = parent
    }
}
