//
//  ServerView.swift
//  MPCRemote
//
//  Created by doroshenko on 03.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerView: View {

    @State var server: Server

    var body: some View {
        HStack {
            Image(systemName: "desktopcomputer")
                .font(.title)

            VStack(alignment: .leading) {
                Text(server.name)
                    .font(.headline)
                Text(server.id)
                    .font(.subheadline)
            }

            Spacer()

            Image(systemName: server.favorite ? "star.fill" : "star")
                .font(.title)
        }
        .padding()
    }
}

struct ServerView_Previews: PreviewProvider {

    static var previews: some View {
        ServerView(server: Server(address: "192.0.2.0"))
            .previewStyle(.compact)
    }
}
