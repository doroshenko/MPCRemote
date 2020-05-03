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
        NavigationView {
            VStack {
                settingsView()
                titleView()
                Spacer()
                seekView()
                Spacer()
                playbackView()
                Spacer()
                bottomView()
            }
            .screenWidth(padding: Constants.padding)
        }
        .foregroundColor(.main)
        .accentColor(.accentStart)
    }
}

private extension PlayerView {

    func settingsView() -> some View {
        NavigationLink(destination: SettingsView()) {
            HStack {
                Spacer()
                Image(systemName: "gear")
                    .resizable().frame(width: Constants.settings, height: Constants.settings)
            }
        }
        .navigationBarTitle(Text(Bundle.main.displayName), displayMode: .inline)
    }

    func titleView() -> some View {
        Text(model.file)
            .multilineTextAlignment(.center)
            .frame(height: 70)
            .screenWidth(padding: Constants.padding)
    }

    func seekView() -> some View {
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

    func playbackView() -> some View {
        HStack {
            PlayerButton(action: {
                self.model.post(command: .skipBackward)
            }, longPressAction: {
                self.model.post(command: .skipBackwardFile)
            }, image: Image(systemName: "backward.end.alt.fill"),
               scale: .navigation)

            PlayerButton(action: {
                self.model.post(command: .seekBackwardMedium)
            }, longPressAction: {
                self.model.post(command: .seekBackwardLarge)
            }, image: Image(systemName: "backward.fill"),
               scale: .navigation)

            PlayerButton(action: {
                self.model.post(command: .playPause)
            }, image: Image(systemName: model.state == .playing ? "pause.fill" : "play.fill"),
               scale: .play)

            PlayerButton(action: {
                self.model.post(command: .seekForwardMedium)
            }, longPressAction: {
                self.model.post(command: .seekForwardLarge)
            }, image: Image(systemName: "forward.fill"),
               scale: .navigation)

            PlayerButton(action: {
                self.model.post(command: .skipForward)
            }, longPressAction: {
                self.model.post(command: .skipForwardFile)
            }, image: Image(systemName: "forward.end.alt.fill"),
               scale: .navigation)
        }
        .screenWidth(padding: Constants.padding)
    }

    func volumeView() -> some View {
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

    func controlView() -> some View {
        HStack {
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .mute)
            }, image: Image(systemName: model.isMuted ? "speaker.2.fill" : "speaker.slash.fill"),
               scale: .control)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .audioNext)
            }, image: Image(systemName: "t.bubble"),
               scale: .control)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .subtitleNext)
            }, image: Image(systemName: "captions.bubble"),
               scale: .control)
            Spacer()
            PlayerButton(action: {
                self.model.post(command: .fullscreen)
            }, image: Image(systemName: "viewfinder"),
               scale: .control)
            Spacer()
        }
        .padding(.vertical, Constants.padding)
        .screenWidth(padding: Constants.padding)
    }

    func bottomView() -> some View {
        VStack {
            volumeView()
            Divider()
            controlView()
        }
    }
}

private struct Constants {
    static let padding: CGFloat = 20
    static let settings: CGFloat = 44
}

struct PlayerView_Previews: PreviewProvider {

   static var previews: some View {
        PlayerView(model: PlayerViewModel())
            .previewStyle(.full)
    }
}
