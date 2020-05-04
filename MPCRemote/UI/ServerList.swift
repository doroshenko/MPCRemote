//
//  ServerList.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerList: View {

    @State var servers = [Server]()

    var body: some View {
        List(servers) { server in
            Button(action: {
                logInfo("Server set as default: \(server)", domain: .ui)
                StorageService.server = server
            }, label: {
                ServerView(server: server)
            })
        }
        .onDisappear(perform: {
            self.cancelAction()
        })
        .navigationBarTitle(Text("Server List"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button("Scan") {
                self.scanAction()
            }
        )
    }

    private func scanAction() {
        logDebug(domain: .ui)
        servers = []
        NetworkService.scan(complete: true, completion: { server in
            self.servers.append(server)
        })
    }

    private func cancelAction() {
        logDebug(domain: .ui)
        NetworkService.cancel()
    }
}

struct ServerList_Previews: PreviewProvider {

    static let fallbackServers = [Server(address: "192.0.2.0"),
                                  Server(address: "192.0.2.1"),
                                  Server(address: "192.0.2.2")]
    static let servers = StorageService.servers.isEmpty ? fallbackServers : StorageService.servers

    static var previews: some View {
        ServerList(servers: servers)
            .previewStyle(.full)
    }
}
