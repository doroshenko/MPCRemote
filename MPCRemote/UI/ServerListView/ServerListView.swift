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
        ZStack {
            List {
                ForEach(model.serverList) { serverListItem in
                    Button(action: {
                        logInfo("Server set as default: \(serverListItem.server)", domain: .ui)
                        self.action?.select(serverListItem)
                    }, label: {
                        ServerView(serverListItem: serverListItem, isActive: self.model.server == serverListItem.server)
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
                UITableView.appearance().tableFooterView = UIView()
                DispatchQueue.main.async {
                    self.action?.setup()
                }
            }
            .onDisappear {
                logDebug(domain: .ui)
                self.action?.cancel()
            }
            .navigationBarTitle(Text("Server List"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(model.serverListState.isScanning ? "Cancel" : "Scan") {
                    logDebug(domain: .ui)
                    if self.model.serverListState.isScanning {
                        self.action?.cancel()
                    } else {
                        self.action?.scan()
                    }
                }
            )
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    AddServerButton {
                        self.action?.setEditing(true)
                    }
                    .popover(isPresented: Binding<Bool>(get: {
                        self.model.serverListState.isEditing
                    }, set: { newValue in
                        self.action?.setEditing(newValue)
                    }), arrowEdge: .bottom) {
                        self.composer?.showServerCreateView()
                    }
                }
            }
        }
    }
}

struct ServerListView_Previews: PreviewProvider {
    static var previews: some View {
        Core.composer.serverListView()
            .previewStyle(.full)
    }
}
