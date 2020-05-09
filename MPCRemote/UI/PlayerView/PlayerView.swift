//
//  PlayerView.swift
//  MPCRemote
//
//  Created by doroshenko on 20.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerView: View {

    @ObservedObject private(set) var model: PlayerViewModel

    let action: PlayerViewActionCreator?
    let composer: PlayerViewComposer?

    let timer = Timer.publish(every: .fetch, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationView {
            playerStack()
                .navigationBarTitle(Text(Bundle.main.displayName), displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink(destination: composer?.showServerListView()) {
                        Text("Settings")
                    }
                )
                .onAppear {
                    self.action?.setup()
                }
        }
        .accentColor(.accentStart)
        .onReceive(timer) { _ in
            self.action?.getState()
        }
    }
}

private extension PlayerView {

    func playerStack() -> some View {
        VStack {
            Spacer()
            titleView()
            Spacer()
            seekView()
            Spacer()
            playbackView()
            Spacer()
            bottomView()
        }
        .foregroundColor(.main)
        .screenWidth(padding: Constants.padding)
    }

    func titleView() -> some View {
        Text(model.playerState.file)
            .multilineTextAlignment(.center)
            .frame(height: 70)
            .screenWidth(padding: Constants.padding)
    }

    func seekView() -> some View {
//        SeekSliderView(position: $model.position.value,
//                       duration: model.playerState.duration,
//                       onEditingChanged: { isEditing in
//                        self.model.isUpdating = isEditing
//
//                        if !isEditing {
//                            self.action?.post(seek: self.model.seek)
//                        }
//        })
//            .disabled(model.playerState.duration == 0)
    }

    func playbackView() -> some View {
        HStack {
            PlayerButton(action: {
                self.action?.post(command: .skipBackward)
            }, longPressAction: {
                self.action?.post(command: .skipBackwardFile)
            }, image: Image(systemName: "backward.end.alt.fill"),
               scale: .navigation)

            PlayerButton(action: {
                self.action?.post(command: .seekBackwardMedium)
            }, longPressAction: {
                self.action?.post(command: .seekBackwardLarge)
            }, image: Image(systemName: "backward.fill"),
               scale: .navigation)

            PlayerButton(action: {
                self.action?.post(command: .playPause)
            }, image: Image(systemName: model.playerState.state == .playing ? "pause.fill" : "play.fill"),
               scale: .play)

            PlayerButton(action: {
                self.action?.post(command: .seekForwardMedium)
            }, longPressAction: {
                self.action?.post(command: .seekForwardLarge)
            }, image: Image(systemName: "forward.fill"),
               scale: .navigation)

            PlayerButton(action: {
                self.action?.post(command: .skipForward)
            }, longPressAction: {
                self.action?.post(command: .skipForwardFile)
            }, image: Image(systemName: "forward.end.alt.fill"),
               scale: .navigation)
        }
        .screenWidth(padding: Constants.padding)
    }

    func volumeView() -> some View {
        HStack {
            Image(systemName: "speaker.1.fill")
//            VolumeSliderView(volume: $model.volume.value,
//                             onEditingChanged: { isEditing in
//                                self.model.volume.isUpdating = isEditing
//
//                                if !isEditing {
//                                    self.action?.post(volume: self.model.volume.value)
//                                }
//            })
            Image(systemName: "speaker.3.fill")
        }
        .padding(.vertical)
    }

    func controlView() -> some View {
        HStack {
            Spacer()
            PlayerButton(action: {
                self.action?.post(command: .mute)
            }, image: Image(systemName: model.playerState.isMuted ? "speaker.2.fill" : "speaker.slash.fill"),
               scale: .control)
            Spacer()
            PlayerButton(action: {
                self.action?.post(command: .audioNext)
            }, image: Image(systemName: "t.bubble"),
               scale: .control)
            Spacer()
            PlayerButton(action: {
                self.action?.post(command: .subtitleNext)
            }, image: Image(systemName: "captions.bubble"),
               scale: .control)
            Spacer()
            PlayerButton(action: {
                self.action?.post(command: .fullscreen)
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
        Core.composer.playerView()
            .previewStyle(.full)
    }
}
