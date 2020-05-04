//
//  PlayerView.swift
//  MPCRemote
//
//  Created by doroshenko on 20.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerView: View {

    let factory: Factory

    @ObservedObject var playerModel: PlayerViewModel
    @ObservedObject var serverListModel: ServerListModel

    var body: some View {
        NavigationView {
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
            .navigationBarTitle(Text(Bundle.main.displayName), displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: factory.serverList(model: serverListModel)) {
                    Text("Settings")
                }
            )
        }
        .accentColor(.accentStart)
    }
}

private extension PlayerView {

    func titleView() -> some View {
        Text(playerModel.file)
            .multilineTextAlignment(.center)
            .frame(height: 70)
            .screenWidth(padding: Constants.padding)
    }

    func seekView() -> some View {
        VStack {
            HStack {
                Text(playerModel.position.seekDescription)
                Spacer()
                Text(playerModel.duration.seekDescription)
            }
            SeekSliderView(value: $playerModel.position,
                           range: 0...playerModel.duration.clamped(to: 1...),
                           onEditingChanged: { isSliding in
                            self.playerModel.isSeekSliding = isSliding
            })
                .disabled(playerModel.duration == 0)
        }
    }

    func playbackView() -> some View {
        HStack {
            PlayerButton(action: {
                self.playerModel.post(command: .skipBackward)
            }, longPressAction: {
                self.playerModel.post(command: .skipBackwardFile)
            }, image: Image(systemName: "backward.end.alt.fill"),
               scale: .navigation)

            PlayerButton(action: {
                self.playerModel.post(command: .seekBackwardMedium)
            }, longPressAction: {
                self.playerModel.post(command: .seekBackwardLarge)
            }, image: Image(systemName: "backward.fill"),
               scale: .navigation)

            PlayerButton(action: {
                self.playerModel.post(command: .playPause)
            }, image: Image(systemName: playerModel.state == .playing ? "pause.fill" : "play.fill"),
               scale: .play)

            PlayerButton(action: {
                self.playerModel.post(command: .seekForwardMedium)
            }, longPressAction: {
                self.playerModel.post(command: .seekForwardLarge)
            }, image: Image(systemName: "forward.fill"),
               scale: .navigation)

            PlayerButton(action: {
                self.playerModel.post(command: .skipForward)
            }, longPressAction: {
                self.playerModel.post(command: .skipForwardFile)
            }, image: Image(systemName: "forward.end.alt.fill"),
               scale: .navigation)
        }
        .screenWidth(padding: Constants.padding)
    }

    func volumeView() -> some View {
        HStack {
            Image(systemName: "speaker.1.fill")
            VolumeSliderView(value: $playerModel.volume,
                             onEditingChanged: { isSliding in
                                self.playerModel.isVolumeSliding = isSliding
            })
            Image(systemName: "speaker.3.fill")
        }
        .padding(.vertical)
    }

    func controlView() -> some View {
        HStack {
            Spacer()
            PlayerButton(action: {
                self.playerModel.post(command: .mute)
            }, image: Image(systemName: playerModel.isMuted ? "speaker.2.fill" : "speaker.slash.fill"),
               scale: .control)
            Spacer()
            PlayerButton(action: {
                self.playerModel.post(command: .audioNext)
            }, image: Image(systemName: "t.bubble"),
               scale: .control)
            Spacer()
            PlayerButton(action: {
                self.playerModel.post(command: .subtitleNext)
            }, image: Image(systemName: "captions.bubble"),
               scale: .control)
            Spacer()
            PlayerButton(action: {
                self.playerModel.post(command: .fullscreen)
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
        DependencyContainer().playerView()
            .previewStyle(.full)
    }
}
