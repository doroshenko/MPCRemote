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
        Text(model.file)
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .frame(width: nil, height: 50)
    }

    var seekView: some View {
        VStack {
            HStack {
                Text(model.position.seekText)
                Spacer()
                Text(model.duration.seekText)
            }
            SeekSliderView(value: $model.position,
                           range: 0...model.duration.clamped(to: 1...),
                           onEditingChanged: { isSliding in
                            self.model.isSeekSliding = isSliding
            })
                .disabled(model.duration == 0)
        }
    }

    var playbackView: some View {
        HStack {
            PlayerButton(action: {
                self.model.post(command: .skipBackward)
            }, longPressAction: {
                self.model.post(command: .skipBackwardFile)
            }, image: Image(systemName: "backward.end.alt.fill"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .seekBackwardMedium)
            }, longPressAction: {
                self.model.post(command: .seekBackwardLarge)
            }, image: Image(systemName: "backward.fill"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .playPause)
            }, image: Image(systemName: model.state == .playing ? "pause.fill" : "play.fill"),
               scale: .medium)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .seekForwardMedium)
            }, longPressAction: {
                self.model.post(command: .seekForwardLarge)
            }, image: Image(systemName: "forward.fill"),
               scale: .small)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .skipForward)
            }, longPressAction: {
                self.model.post(command: .skipForwardFile)
            }, image: Image(systemName: "forward.end.alt.fill"),
               scale: .small)
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
        .padding(.vertical)
    }

    var controlView: some View {
        HStack {
            PlayerButton(action: {
                self.model.post(command: .mute)
            }, image: Image(systemName: model.isMuted ? "speaker.2.fill" : "speaker.slash.fill"),
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
    .padding()
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
