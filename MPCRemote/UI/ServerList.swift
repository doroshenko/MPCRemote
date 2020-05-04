//
//  ServerList.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerList: View {

    @ObservedObject var model = ServerListModel()

    var body: some View {
        List(model.servers) { server in
            Button(action: {
                logInfo("Server set as default: \(server)", domain: .ui)
                StorageService.server = server
            }, label: {
                ServerView(server: server)
            })
        }
        .onDisappear(perform: {
            logDebug(domain: .ui)
            self.model.cancelAction()
        })
        .navigationBarTitle(Text("Server List"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button("Scan") {
                logDebug(domain: .ui)
                self.model.scanAction()
            }
        )
    }
}

struct ServerList_Previews: PreviewProvider {
    static var previews: some View {
        ServerList()
            .previewStyle(.full)
    }
}
