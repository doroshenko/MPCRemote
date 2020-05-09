//
//  PlayerStateProvider.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol PlayerStateProviderType {
    var hasServer: Bool { get }
    func findServer(completion: @escaping () -> Void)

    func getState(completion: @escaping (PlayerState) -> Void)
    func post(command: Command, completion: @escaping (PlayerState) -> Void)
    func post(seek: Double, completion: @escaping (PlayerState) -> Void)
    func post(volume: Double, completion: @escaping (PlayerState) -> Void)
}

struct PlayerStateProvider: PlayerStateProviderType {

    private let apiService: APIServiceType
    private let settingsService: SettingsServiceType
    private let networkService: NetworkServiceType

    init(apiService: APIServiceType, networkService: NetworkServiceType, settingsService: SettingsServiceType) {
        self.apiService = apiService
        self.networkService = networkService
        self.settingsService = settingsService
    }
}

extension PlayerStateProvider {

    var hasServer: Bool {
        !settingsService.isEmpty
    }

    func findServer(completion: @escaping () -> Void) {
        logInfo("No server preset found", domain: .ui)
        networkService.scan(complete: false, completion: { server in
            logInfo("Using first found server as default: \(server)", domain: .ui)
            self.settingsService.add(server: server)
            completion()
        })
    }
}

extension PlayerStateProvider {

    func getState(completion: @escaping (PlayerState) -> Void) {
       apiService.getState(server: settingsService.server) { result in
            self.handleStateResult(result, completion: completion)
        }
    }

    func post(command: Command, completion: @escaping (PlayerState) -> Void) {
        apiService.post(command: command, server: settingsService.server) { result in
            self.handlePostResult(result, completion: completion)
        }
    }

    func post(seek: Double, completion: @escaping (PlayerState) -> Void) {
        apiService.post(seek: seek, server: settingsService.server) { result in
            self.handlePostResult(result, completion: completion)
        }
    }

    func post(volume: Double, completion: @escaping (PlayerState) -> Void) {
        apiService.post(volume: volume, server: settingsService.server) { result in
            self.handlePostResult(result, completion: completion)
        }
    }
}

private extension PlayerStateProvider {

    func handleStateResult(_ result: StateResult, completion: @escaping (PlayerState) -> Void) {
        switch result {
        case let .success(state):
            completion(state)
        case let .failure(error):
            logDebug(error.localizedDescription, domain: .api)
        }
    }

    func handlePostResult(_ result: PostResult, completion: @escaping (PlayerState) -> Void) {
        switch result {
        case .success:
            getState(completion: completion)
        case let .failure(error):
            logDebug(error.localizedDescription, domain: .api)
        }
    }
}
