//
//  ServerView.swift
//  MPCRemote
//
//  Created by doroshenko on 03.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerView: View {

    var server: Server

    var body: some View {

        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ServerView_Previews: PreviewProvider {

    static let server = StorageService.server ?? Server(address: "192.0.2.0")

    static var previews: some View {
        ServerView(server: server)
            .previewStyle(.compact)
    }
}
