//
//  PlayerViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 27.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Combine

final class PlayerViewModel: ObservableObject {

    @Published private(set) var playerState: PlayerState

    @Published var position: PositionSliderViewModel
    @Published var volume: VolumeSliderViewModel

//    var seek: Double {
//        guard playerState.duration != 0 else { return 0 }
//
//        return position * Parameter.Seek.range.upperBound / playerState.duration
//    }

    private var cancellable = Set<AnyCancellable>()

    init(data: DataStore) {
        self.playerState = data.playerState
        self.position = PositionSliderViewModel(data: data)
        self.volume = VolumeSliderViewModel(data: data)

        // One-way binding to the value in DataStore
        data.$playerState
            .removeDuplicates()
            .assign(to: \Self.playerState, on: self)
            .store(in: &cancellable)
    }
}
