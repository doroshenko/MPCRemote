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

    @Published var position: Double
    @Published var volume: Double

    var seek: Double {
        guard playerState.duration != 0 else { return 0 }

        return position * Parameter.Seek.range.upperBound / playerState.duration
    }

    var isUpdatingPosition: Bool = false
    var isUpdatingVolume: Bool = false

    private var cancellable = Set<AnyCancellable>()

    init(data: DataStore) {
        self.playerState = data.playerState
        self.position = data.playerState.position
        self.volume = data.playerState.volume

        // One-way binding to the value in DataStore
        data.$playerState
            .removeDuplicates()
            .assign(to: \Self.playerState, on: self)
            .store(in: &cancellable)

        data.$playerState
            .map { $0.position }
            .removeDuplicates()
            .filter { _ in
                !self.isUpdatingPosition
            }
            .assign(to: \Self.position, on: self)
            .store(in: &cancellable)

        data.$playerState
            .map { $0.volume }
            .removeDuplicates()
            .filter { _ in
                !self.isUpdatingVolume
            }
            .assign(to: \Self.volume, on: self)
            .store(in: &cancellable)
    }
}
