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
        List(model.serverList) { server in
            Button(action: {
                logInfo("Server set as default: \(server)", domain: .ui)
                self.action?.add(server: server)
            }, label: {
                ServerView(server: server)
                    .onAppear {
                        self.action?.ping(server: server) { _ in
                            // TOOO: change cell appearance based on server availability
                        }
                }
            })
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
            Button("Scan") {
                logDebug(domain: .ui)
                self.action?.scan()
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
