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

    private var cancellable = Set<AnyCancellable>()

    init(data: DataStore) {
        self.playerState = data.playerState

        // One-way binding to the value in DataStore
        data.$playerState
            .removeDuplicates()
            .assign(to: \Self.playerState, on: self)
            .store(in: &cancellable)
    }
}
