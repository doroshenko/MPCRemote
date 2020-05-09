//
//  PlayerViewComposer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerViewComposer: ComposerType {
    private let parent: Composer

    init(parent: Composer) {
        self.parent = parent
    }
}

extension PlayerViewComposer {

    func showServerListView() -> some View {
        parent.serverListView()
    }
}

extension PlayerViewComposer {

    func seekSliderView(_ viewModel: SeekSliderViewModel) -> some View {
        parent.seekSliderView(viewModel)
    }

    func volumeSliderView(_ viewModel: VolumeSliderViewModel) -> some View {
        parent.volumeSliderView(viewModel)
    }
}
