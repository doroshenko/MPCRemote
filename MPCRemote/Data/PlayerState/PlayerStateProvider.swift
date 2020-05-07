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

    func getState(completion: @escaping StateHandler)
    func post(command: Command, completion: @escaping PostHandler)
    func post(seek: Double, completion: @escaping PostHandler)
    func post(volume: Double, completion: @escaping PostHandler)
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

    func getState(completion: @escaping StateHandler) {
        apiService.getState(server: settingsService.server, completion: completion)
    }

    func post(command: Command, completion: @escaping PostHandler) {
        apiService.post(command: command, server: settingsService.server, completion: completion)
    }

    func post(seek: Double, completion: @escaping PostHandler) {
        apiService.post(seek: seek, server: settingsService.server, completion: completion)
    }

    func post(volume: Double, completion: @escaping PostHandler) {
        apiService.post(volume: volume, server: settingsService.server, completion: completion)
    }
}
