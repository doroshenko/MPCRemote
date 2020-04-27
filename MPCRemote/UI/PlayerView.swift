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
    @State var seek: Int = 0
    @State var volume: Int = 0

    let timer = Timer.publish(every: Timeout.refresh, on: .main, in: .common).autoconnect()

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
            Slider(value: Binding(get: {
                Double(self.seek)
            }, set: { newValue in
                self.seek = Int(newValue)
                self.post(seek: self.seek)
            }),
                   in: Parameter.Seek.doubleRange,
                   step: 1)
        }
    }

    var playbackView: some View {
        HStack {
            PlayerButton(action: {
                self.post(command: .seekBackwardMedium)
            }, image: Image(systemName: "backward.fill"),
               scale: .medium)
            Spacer()
            PlayerButton(action: {
                self.post(command: .playPause)
            }, image: Image(systemName: playerState.isPlaying ? "pause.fill" : "play.fill"),
               scale: .large)
            Spacer()
            PlayerButton(action: {
                self.post(command: .seekForwardMedium)
            }, image: Image(systemName: "forward.fill"),
               scale: .medium)
        }
    }

    var volumeView: some View {
        HStack {
            Image(systemName: "speaker.fill")
            Slider(value: Binding(get: {
                Double(self.volume)
            }, set: { newValue in
                self.volume = Int(newValue)
                self.post(volume: self.volume)
            }),
                   in: Parameter.Volume.doubleRange,
                   step: 1)
            Image(systemName: "speaker.3.fill")
        }
        .foregroundColor(.accentColor)
    }

    var controlView: some View {
        HStack {
            PlayerButton(action: {
                self.post(command: .mute)
            }, image: Image(systemName: playerState.muted ? "speaker.2.fill" : "speaker.slash"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                self.post(command: .audioNext)
            }, image: Image(systemName: "t.bubble"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                self.post(command: .subtitleNext)
            }, image: Image(systemName: "captions.bubble"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                self.post(command: .fullscreen)
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
                self.seek = state.seek
                self.volume = state.volume
            case let .failure(error):
                logDebug(error.localizedDescription, domain: .api)
            }
        }
    }

    var postCompletion: PostResult { { result in
            guard case .success() = result else { return }
            self.refreshPlayerState()
        }
    }

    func post(command: Command) {
        APIService.post(command: command, completion: postCompletion)
    }

    func post(seek: Int) {
        APIService.post(seek: seek, completion: postCompletion)
    }

    func post(volume: Int) {
        APIService.post(volume: volume, completion: postCompletion)
    }
}

struct PlayerView_Previews: PreviewProvider {

   static var previews: some View {
        PlayerView()
    }
}
