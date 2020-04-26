//
//  PlayerView.swift
//  MPCRemote
//
//  Created by doroshenko on 20.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerView: View {

    @State private var playerState: PlayerState = .default
    @State private var seek: Double = 0
    @State private var volume: Double = 0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Spacer()
            titleView
            Spacer()
            seekView
            Spacer()
            playbackView
            Spacer()
            volumeView
            Divider()
            controlView
        }
        .padding()
        .onReceive(timer) { _ in
            self.refreshPlayerState()
        }
    }

    var titleView: some View {
        Text(playerState.file)
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .frame(width: nil, height: 50)
    }

    var seekView: some View {
        VStack {
            HStack {
                Text(playerState.positionString)
                Spacer()
                Text(playerState.durationString)
            }
            Slider(value: $seek, in: Parameter.Seek.range, step: 0.1)
        }
    }

    var playbackView: some View {
        HStack {
            PlayerButton(action: {
                APIService.post(command: .seekBackwardMedium)
            }, image: Image(systemName: "backward.fill"),
               scale: .medium)
            Spacer()
            PlayerButton(action: {
                APIService.post(command: .playPause)
            }, image: Image(systemName: playerState.isPlaying ? "pause.fill" : "play.fill"),
               scale: .large)
            Spacer()
            PlayerButton(action: {
                APIService.post(command: .seekForwardMedium)
            }, image: Image(systemName: "forward.fill"),
               scale: .medium)
        }
    }

    var volumeView: some View {
        HStack {
          Image(systemName: "speaker.fill")
          Slider(value: $volume, in: Parameter.Seek.range, step: 0.1)
          Image(systemName: "speaker.3.fill")
        }
        .foregroundColor(.accentColor)
    }

    var controlView: some View {
        HStack {
            PlayerButton(action: {
                APIService.post(command: .mute)
            }, image: Image(systemName: playerState.isQuiet ? "speaker.2.fill" : "speaker.slash"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                APIService.post(command: .audioNext)
            }, image: Image(systemName: "t.bubble"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                APIService.post(command: .subtitleNext)
            }, image: Image(systemName: "captions.bubble"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                APIService.post(command: .fullscreen)
            }, image: Image(systemName: "viewfinder"),
               scale: .small)
        }
    }
}

extension PlayerView {

    func refreshPlayerState() {
        APIService.getState { result in
            switch result {
            case let .success(state):
                self.playerState = state
            case let .failure(error):
                logDebug(error.localizedDescription, domain: .api)
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {

   static var previews: some View {
        PlayerView()
    }
}
