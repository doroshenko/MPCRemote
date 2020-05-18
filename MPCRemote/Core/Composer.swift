//
//  Composer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct Composer {
    private let resolver: Resolver
    private let data: DataStore

    init(resolver: Resolver, data: DataStore) {
        self.resolver = resolver
        self.data = data
    }
}

// MARK: - Scenes

extension Composer {

    func playerView() -> some View {
        PlayerView(
            model: PlayerViewModel(data: data),
            action: PlayerViewActionCreator(provider: resolver.resolve(),
                                            dispatch: action(to: PlayerViewReducer())),
            composer: PlayerViewComposer(parent: self)
        )
    }
}

extension Composer {

    func serverListView() -> some View {
        ServerListView(
            model: ServerListViewModel(data: data),
            action: ServerListViewActionCreator(provider: resolver.resolve(),
                                                dispatch: action(to: ServerListViewReducer())),
            composer: ServerListViewComposer(parent: self)
        )
    }
}

extension Composer {

    func seekSliderView() -> some View {
        seekSliderView(SeekSliderViewModel(data: data))
    }

    func seekSliderView(_ viewModel: SeekSliderViewModel) -> some View {
        SliderView(model: viewModel,
                   action: SeekSliderViewActionCreator(provider: resolver.resolve(),
                                                       dispatch: action(to: SliderViewReducer())),
                   composer: SliderViewComposer(parent: self))
    }
}

extension Composer {

    func volumeSliderView() -> some View {
        volumeSliderView(VolumeSliderViewModel(data: data))
    }

    func volumeSliderView(_ viewModel: VolumeSliderViewModel) -> some View {
        SliderView(model: viewModel,
                   action: VolumeSliderViewActionCreator(provider: resolver.resolve(),
                                                         dispatch: action(to: SliderViewReducer())),
                   composer: SliderViewComposer(parent: self))
    }
}

// TODO: refactor this. keep reducer creation localized to a single point
extension Composer {

    func action<Action, Reducer>(to reducer: Reducer) -> (Action) -> Void
        where Reducer: ReducerType, Reducer.Action == Action { { action in
            reducer.reduce(self, self.data, action)
        }
    }

    func action<Action, Reducer>(to reducer: Reducer, with newAction: Action)
        where Reducer: ReducerType, Reducer.Action == Action {
            action(to: reducer)(newAction)
    }
}
