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
                                            timerHolder: resolver.resolve(),
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

private extension Composer {

    func action<Action, Reducer>(to reducer: Reducer) -> (Action) -> Void
        where Reducer: ReducerType, Reducer.Action == Action { { action in
            reducer.reduce(self.data, action)
        }
    }
}
