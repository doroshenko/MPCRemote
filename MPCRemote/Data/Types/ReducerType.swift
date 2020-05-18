//
//  ReducerType.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol ReducerType {
    associatedtype Action: ActionType

    // TODO: avoid passing composer directly
    func reduce(_ composer: Composer, _ data: DataStore, _ action: Action)
}
