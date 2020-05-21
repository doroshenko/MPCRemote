//
//  Dispatcher.swift
//  MPCRemote
//
//  Created by doroshenko on 21.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct Dispatcher {
    private let data: DataStore

    init(data: DataStore) {
        self.data = data
    }
}

extension Dispatcher {

    func dispatch<Action, Reducer>(to reducer: Reducer) -> (Action) -> Void
        where Reducer: ReducerType, Reducer.Action == Action { { action in
            self.dispatch(action: action, to: reducer)
        }
    }

    func dispatch<Action, Reducer>(action: Action, to reducer: Reducer)
        where Reducer: ReducerType, Reducer.Action == Action {
            reducer.reduce(self, self.data, action)
    }
}
