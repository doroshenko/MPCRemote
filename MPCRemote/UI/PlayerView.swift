//
//  PlayerView.swift
//  MPCRemote
//
//  Created by doroshenko on 20.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerView: View {

    @ObservedObject var model: PlayerViewModel

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
    }

    var titleView: some View {
        Text(model.playerState.file)
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .frame(width: nil, height: 50)
    }

    var seekView: some View {
        VStack {
            HStack {
                Text(model.playerState.positionString)
                Spacer()
                Text(model.playerState.durationString)
            }
            Slider(value: Binding(get: {
                Double(self.model.seek)
            }, set: { newValue in
                self.model.seek = Int(newValue)
                self.model.postSeek()
            }),
                   in: Parameter.Seek.doubleRange,
                   step: 1)
        }
    }

    var playbackView: some View {
        HStack {
            PlayerButton(action: {
                self.model.post(command: .seekBackwardMedium)
            }, image: Image(systemName: "backward.fill"),
               scale: .medium)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .playPause)
            }, image: Image(systemName: model.playerState.isPlaying ? "pause.fill" : "play.fill"),
               scale: .large)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .seekForwardMedium)
            }, image: Image(systemName: "forward.fill"),
               scale: .medium)
        }
    }

    var volumeView: some View {
        HStack {
            Image(systemName: "speaker.fill")
            Slider(value: Binding(get: {
                Double(self.model.volume)
            }, set: { newValue in
                self.model.volume = Int(newValue)
                self.model.postVolume()
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
                self.model.post(command: .mute)
            }, image: Image(systemName: model.playerState.muted ? "speaker.2.fill" : "speaker.slash"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .audioNext)
            }, image: Image(systemName: "t.bubble"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .subtitleNext)
            }, image: Image(systemName: "captions.bubble"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .fullscreen)
            }, image: Image(systemName: "viewfinder"),
               scale: .small)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {

   static var previews: some View {
        PlayerView(model: PlayerViewModel())
    }
}
