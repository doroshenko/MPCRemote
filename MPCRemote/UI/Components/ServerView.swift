//
//  ServerView.swift
//  MPCRemote
//
//  Created by doroshenko on 03.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerView: View {

    var serverListItem: ServerListItem
    var isActive: Bool

    var body: some View {
        HStack {
            Image(systemName: "desktopcomputer")
                .foregroundColor(serverListItem.isOnline ? Color.accentStart : Color(.systemGray))
                .font(.title)

            VStack(alignment: .leading) {
                Text(serverListItem.server.name)
                    .font(.headline)
                Text(serverListItem.server.id)
                    .font(.subheadline)
            }

            Spacer()

            Image(systemName: serverListItem.isFavorite ? "star.fill" : "star")
                .foregroundColor(isActive ? .accentStart : .main)
                .font(.title)
        }
        .padding()
    }
}

struct ServerView_Previews: PreviewProvider {

    static let offline = ServerListItem(server: Server(address: "192.0.2.0"), isFavorite: false, isOnline: false)
    static let online = ServerListItem(server: Server(address: "192.0.2.1"), isFavorite: false, isOnline: true)
    static let favorite = ServerListItem(server: Server(address: "192.0.2.2"), isFavorite: true, isOnline: true)

    static var previews: some View {
        Group {
            ServerView(serverListItem: offline, isActive: false)
            ServerView(serverListItem: online, isActive: true)
            ServerView(serverListItem: favorite, isActive: true)
        }
            .previewStyle(.compact)
    }
}
