//
//  Resolver.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol Resolver {
    func resolve() -> APIServiceType
    func resolve() -> NetworkServiceType
    func resolve() -> SettingsServiceType

    func resolve() -> OperationProviderType
    func resolve() -> PlayerStateProviderType
    func resolve() -> ServerListProviderType

    func resolve() -> TimerHolderType
}

extension Resolver {

    func resolve() -> APIServiceType {
        APIService()
    }

    func resolve() -> NetworkServiceType {
        NetworkService(operationProvider: resolve())
    }

    func resolve() -> SettingsServiceType {
        SettingsService()
    }
}

extension Resolver {

    func resolve() -> OperationProviderType {
        OperationProvider(apiService: resolve())
    }

    func resolve() -> PlayerStateProviderType {
        PlayerStateProvider(apiService: resolve(),
                            networkService: resolve(),
                            settingsService: resolve())
    }

    func resolve() -> ServerListProviderType {
        ServerListProvider(networkService: resolve(),
                           settingsService: resolve())
    }
}

extension Resolver {

    func resolve() -> TimerHolderType {
        TimerHolder()
    }
}

struct Dependency: Resolver { }
