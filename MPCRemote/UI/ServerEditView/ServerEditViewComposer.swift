//
//  ServerEditViewComposer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerEditViewComposer: ComposerType {
    private let parent: Composer

    init(parent: Composer) {
        self.parent = parent
    }
}

extension ServerEditViewComposer {

    func textLabelAddressView(_ viewModel: TextLabelAddressViewModel) -> some View {
        parent.textLabelAddressView(viewModel)
    }

    func textLabelPortView(_ viewModel: TextLabelPortViewModel) -> some View {
        parent.textLabelPortView(viewModel)
    }

    func textLabelNameView(_ viewModel: TextLabelNameViewModel) -> some View {
        parent.textLabelNameView(viewModel)
    }
}
