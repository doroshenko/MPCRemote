//
//  DependencyContainer.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

typealias Factory = ViewFactory & ViewModelFactory

protocol Resolver {
    func resolve() -> APIService
    func resolve() -> NetworkService
    func resolve() -> StorageService
    func resolve() -> PlayerState
}

protocol ViewFactory {
    func playerView() -> PlayerView
    func serverList() -> ServerList
}

protocol ViewModelFactory {
    func playerViewModel() -> PlayerViewModel
    func serverListModel() -> ServerListModel

    func ping(hostName: String, completion: @escaping PingResult) -> Ping
    func validation(server: Server, completion: @escaping StateResult) -> Validation
}

class DependencyContainer {
    private lazy var apiService = APIService()
    private lazy var networkService = NetworkService(factory: self)
    private lazy var storageService = StorageService()
    private lazy var playerState = PlayerState()
}

extension DependencyContainer: Resolver {
    func resolve() -> APIService {
        apiService
    }

    func resolve() -> NetworkService {
        networkService
    }

    func resolve() -> StorageService {
        storageService
    }

    func resolve() -> PlayerState {
        playerState
    }
}

extension DependencyContainer: ViewFactory {
    func playerView() -> PlayerView {
        PlayerView(factory: self, model: playerViewModel())
    }

    func serverList() -> ServerList {
        ServerList(model: serverListModel())
    }
}

extension DependencyContainer: ViewModelFactory {
    func playerViewModel() -> PlayerViewModel {
        PlayerViewModel(resolver: self)
    }

    func serverListModel() -> ServerListModel {
        ServerListModel(resolver: self)
    }

    func ping(hostName: String, completion: @escaping PingResult) -> Ping {
        Ping(hostName: hostName, completion: completion)
    }

    func validation(server: Server, completion: @escaping StateResult) -> Validation {
        Validation(resolver: self, server: server, completion: completion)
    }
}
