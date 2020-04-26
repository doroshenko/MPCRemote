//
//  PlayerView.swift
//  MPCRemote
//
//  Created by doroshenko on 20.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerView: View {

    @Binding var playerState: PlayerState

    var body: some View {
        VStack {
            PlayerButton(action: {
                logDebug()
            }, image: Image(systemName: "play.fill"),
               scale: .large)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {

    @State private static var playerState: PlayerState = StorageService.state

    static var previews: some View {
        PlayerView(playerState: $playerState)
    }
}
