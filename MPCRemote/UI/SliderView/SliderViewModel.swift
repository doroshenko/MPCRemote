//
//  SliderViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 09.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Combine

class SliderViewModel<T: Equatable>: ObservableObject {

    @Published var value: T
    var maxValue: T
    var formattedValue: T {
        value
    }

    var isUpdating: Bool = false

    private var cancellable = Set<AnyCancellable>()

    init(data: DataStore, maxValue: T, keyPath: KeyPath<PlayerState, T>) {
        self.value = data.playerState[keyPath: keyPath]
        self.maxValue = maxValue

        // One-way binding to the value in DataStore
        data.$playerState
            .map { $0[keyPath: keyPath] }
            .removeDuplicates()
            .filter { _ in
                !self.isUpdating
            }
            .assign(to: \Self.value, on: self)
            .store(in: &cancellable)
    }
}

final class PositionSliderViewModel: SliderViewModel<Double> {

    init(data: DataStore) {
        super.init(data: data, maxValue: data.playerState.duration, keyPath: \.position)
    }

    override var formattedValue: Double {
        guard maxValue != 0 else { return 0 }

        return value * Parameter.Seek.range.upperBound / maxValue
    }
}

final class VolumeSliderViewModel: SliderViewModel<Double> {

    init(data: DataStore) {
        super.init(data: data, maxValue: Parameter.Volume.range.upperBound, keyPath: \.volume)
    }
}
