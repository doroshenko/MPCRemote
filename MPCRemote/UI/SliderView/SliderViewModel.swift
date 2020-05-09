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

    @Published private(set) var isUpdating: Bool

    private var cancellablePlayer = Set<AnyCancellable>()
    private var cancellableSlider = Set<AnyCancellable>()

    init(data: DataStore, maxValue: T, valueKeyPath: KeyPath<PlayerState, T>, updatingKeyPath: KeyPath<SliderState, Bool>) {
        self.value = data.playerState[keyPath: valueKeyPath]
        self.isUpdating = data.sliderState[keyPath: updatingKeyPath]
        self.maxValue = maxValue

        // One-way binding to the value in DataStore
        data.$playerState
            .map { $0[keyPath: valueKeyPath] }
            .removeDuplicates()
            .filter { _ in
                !self.isUpdating
            }
            .assign(to: \Self.value, on: self)
            .store(in: &cancellablePlayer)

        data.$sliderState
            .map { $0[keyPath: updatingKeyPath] }
            .assign(to: \Self.isUpdating, on: self)
            .store(in: &cancellableSlider)
    }

    // MARK: - Formatting

    var formattedValue: T {
        value
    }

    func formattedDescription(_ value: T) -> String {
        String()
    }
}

final class SeekSliderViewModel: SliderViewModel<Double> {

    private var cancellableDuration = Set<AnyCancellable>()

    init(data: DataStore) {
        super.init(data: data,
                   maxValue: data.playerState.duration,
                   valueKeyPath: \.position,
                   updatingKeyPath: \.isSeekUpdating)

        data.$playerState
            .map { $0.duration }
            .removeDuplicates()
            .filter { _ in
                !self.isUpdating
            }
            .assign(to: \Self.maxValue, on: self)
            .store(in: &cancellableDuration)
    }

    override var formattedValue: Double {
        guard maxValue != 0 else { return 0 }

        return value * Parameter.Seek.range.upperBound / maxValue
    }

    override func formattedDescription(_ value: Double) -> String {
        value.seekDescription
    }
}

final class VolumeSliderViewModel: SliderViewModel<Double> {

    init(data: DataStore) {
        super.init(data: data,
                   maxValue: Parameter.Volume.range.upperBound,
                   valueKeyPath: \.volume,
                   updatingKeyPath: \.isVolumeUpdating)
    }
}
