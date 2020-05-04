//
//  ServerList.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerList: View {

    @ObservedObject var model: ServerListModel

    var body: some View {
        List(model.servers) { server in
            Button(action: {
                logInfo("Server set as default: \(server)", domain: .ui)
                self.model.set(server: server)
            }, label: {
                ServerView(server: server)
            })
        }
        .onAppear(perform: {
            logDebug(domain: .ui)
            self.model.setup()
        })
        .onDisappear(perform: {
            logDebug(domain: .ui)
            self.model.cancel()
        })
        .navigationBarTitle(Text("Server List"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button("Scan") {
                logDebug(domain: .ui)
                self.model.scan()
            }
        )
    }
}

struct ServerList_Previews: PreviewProvider {
    static let container = DependencyContainer()
    static var previews: some View {
        container.serverList(model: container.serverListModel())
            .previewStyle(.full)
    }
}
