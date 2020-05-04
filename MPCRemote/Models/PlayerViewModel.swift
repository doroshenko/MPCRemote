//
//  PlayerViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 27.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

final class PlayerViewModel: ObservableObject {

    private var apiService: APIService
    private var networkService: NetworkService
    private var storageService: StorageService

    @Published var file: String
    @Published var state: PlaybackState
    @Published var position: Double
    @Published var duration: Double
    @Published var isMuted: Bool
    @Published var volume: Double

    private var seek: Double {
        guard duration != 0 else { return 0 }

        return Parameter.Seek.range.upperBound * position / duration
    }

    var isSeekSliding: Bool = false {
        didSet {
            if !isSeekSliding {
                post(seek: seek)
            }
        }
    }

    var isVolumeSliding: Bool = false {
        didSet {
            if !isVolumeSliding {
                post(volume: volume)
            }
        }
    }

    init(resolver: Resolver) {
        self.apiService = resolver.resolve()
        self.networkService = resolver.resolve()
        self.storageService = resolver.resolve()

        let playerState: PlayerState = resolver.resolve()
        file = playerState.file
        state = playerState.state
        position = playerState.position
        duration = playerState.duration
        isMuted = playerState.isMuted
        volume = playerState.volume

        setup()

        Timer.scheduledTimer(withTimeInterval: Interval.refresh,
                             repeats: true,
                             block: { [weak self] _ in
                                self?.refresh()
        })
    }

    private func setup() {
        guard storageService.server == nil else {
            refresh()
            return
        }

        logInfo("No server preset found", domain: .ui)
        networkService.scan(complete: false, completion: { server in
            logInfo("Using first found server as default: \(server)", domain: .ui)
            self.storageService.server = server
            self.storageService.servers.appendUnique(server)
            self.refresh()
        })
    }

    private func refresh() {
        apiService.getState(server: storageService.server) { result in
            switch result {
            case let .success(state):
                self.updateProperties(with: state)
            case let .failure(error):
                logDebug(error.localizedDescription, domain: .api)
            }
        }
    }

    private func updateProperties(with playerState: PlayerState) {
        file = playerState.file
        state = playerState.state
        isMuted = playerState.isMuted

        if !isSeekSliding {
            position = playerState.position
            duration = playerState.duration
        }

        if !isVolumeSliding {
            volume = playerState.volume
        }
    }
}

extension PlayerViewModel {

    func post(command: Command) {
        apiService.post(command: command, server: storageService.server) { _ in
            self.refresh()
        }
    }

    func post(seek: Double) {
        apiService.post(seek: seek, server: storageService.server) { _ in
            self.refresh()
        }
    }

    func post(volume: Double) {
        apiService.post(volume: volume, server: storageService.server) { _ in
            self.refresh()
        }
    }
}
