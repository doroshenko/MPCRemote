//
//  ServerList.swift
//  MPCRemote
//
//  Created by doroshenko on 04.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerListView: View {

    @ObservedObject private(set) var model: ServerListViewModel
    let action: ServerListViewActionCreator?
    let composer: ServerListViewComposer?

    var body: some View {
        List {
            ForEach(model.serverList) { serverListItem in
                Button(action: {
                    logInfo("Server set as default: \(serverListItem.server)", domain: .ui)
                    self.action?.select(serverListItem)
                }, label: {
                    ServerView(serverListItem: serverListItem)
                })
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let server = self.model.serverList[index]
                    self.action?.delete(server)
                }
            }
        }
        .onAppear {
            logDebug(domain: .ui)
            self.action?.setup()
        }
        .onDisappear {
            logDebug(domain: .ui)
            self.action?.cancel()
        }
        .navigationBarTitle(Text("Server List"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(model.isScanning ? "Cancel" : "Scan") {
                logDebug(domain: .ui)
                if self.model.isScanning {
                    self.action?.cancel()
                } else {
                    self.action?.scan()
                }
            }
        )
    }
}

struct ServerListView_Previews: PreviewProvider {
    static var previews: some View {
        Core.composer.serverListView()
            .previewStyle(.full)
    }
}
