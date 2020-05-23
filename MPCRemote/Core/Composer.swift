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
    private let dispatcher: Dispatcher
    private let data: DataStore

    init(resolver: Resolver, dispatcher: Dispatcher, data: DataStore) {
        self.resolver = resolver
        self.dispatcher = dispatcher
        self.data = data
    }
}

// MARK: - Scenes

extension Composer {

    func playerView() -> some View {
        PlayerView(
            model: PlayerViewModel(data: data),
            action: PlayerViewActionCreator(provider: resolver.resolve(),
                                            dispatch: dispatcher.dispatch(to: PlayerViewReducer())),
            composer: PlayerViewComposer(parent: self)
        )
    }
}

extension Composer {

    func serverListView() -> some View {
        ServerListView(
            model: ServerListViewModel(data: data),
            action: ServerListViewActionCreator(provider: resolver.resolve(),
                                                dispatch: dispatcher.dispatch(to: ServerListViewReducer())),
            composer: ServerListViewComposer(parent: self)
        )
    }
}

extension Composer {

    func serverCreateView() -> some View {
        serverEditView(nil)
    }

    func serverEditView(_ server: Server?) -> some View {
        ServerEditView(
            model: ServerEditViewModel(server: server),
            action: ServerEditViewActionCreator(provider: resolver.resolve(),
                                                dispatch: dispatcher.dispatch(to: ServerEditViewReducer())),
            composer: ServerEditViewComposer(parent: self)
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
                                                       dispatch: dispatcher.dispatch(to: SliderViewReducer())),
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
                                                         dispatch: dispatcher.dispatch(to: SliderViewReducer())),
                   composer: SliderViewComposer(parent: self))
    }
}
