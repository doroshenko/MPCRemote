//
//  PlayerView.swift
//  MPCRemote
//
//  Created by doroshenko on 20.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerView: View {

    @Binding var playbackState: PlaybackState

    var body: some View {
        Button(action: {
            logInfo()
        }, label: {
            Image(systemName: "play.fill")
        })
        .buttonStyle(PlayerButtonStyle())
    }
}

struct PlayerView_Previews: PreviewProvider {

    @State private static var playbackState: PlaybackState = .default

    static var previews: some View {
        PlayerView(playbackState: $playbackState)
    }
}
