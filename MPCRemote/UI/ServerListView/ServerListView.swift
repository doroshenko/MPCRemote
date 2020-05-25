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
                            .contextMenu { self.contextMenu(serverListItem) }
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
            floatingButton()
        }
    }

    func contextMenu(_ serverListItem: ServerListItem) -> some View {
        VStack {
            Button(action: {
                self.action?.setEditing(true, server: serverListItem.server)
            }, label: {
                Text("Edit")
                Image(systemName: "pencil")
            })
            Button(action: {
                self.action?.delete(serverListItem)
            }, label: {
                Text("Delete")
                Image(systemName: "trash").accentColor(Color(.systemRed))
            })
        }
    }

    func floatingButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                AddServerButton {
                    self.action?.cancel()
                    self.action?.setEditing(true, server: nil)
                }
                .sheet(isPresented: Binding<Bool>(get: {
                    self.model.serverListState.isEditing
                }, set: { editing in
                    self.action?.setEditing(editing, server: nil)
                })) {
                    self.composer?.showServerEditView()
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
