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
                Text(model.position)
                Spacer()
                Text(model.duration)
            }
            SeekSliderView(value: $model.seek,
                           onEditingChanged: { isSliding in
                            self.model.isSeekSliding = isSliding
            })
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
            Image(systemName: "speaker.1.fill")
            VolumeSliderView(value: $model.volume,
                             onEditingChanged: { isSliding in
                                self.model.isVolumeSliding = isSliding
            })
            Image(systemName: "speaker.3.fill")
        }
    }

    var controlView: some View {
        HStack {
            PlayerButton(action: {
                self.model.post(command: .mute)
            }, image: Image(systemName: model.playerState.muted ? "speaker.2.fill" : "speaker.slash.fill"),
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
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            ZStack {
                Color(.systemBackground)
                PlayerView(model: PlayerViewModel())
            }
                .environment(\.colorScheme, scheme)
        }
    }
}
