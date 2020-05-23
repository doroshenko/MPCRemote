//
//  ServerEditView.swift
//  MPCRemote
//
//  Created by doroshenko on 23.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerEditView: View {

    @ObservedObject private(set) var model: ServerEditViewModel
    let action: ServerEditViewActionCreator?
    let composer: ServerEditViewComposer?

    var body: some View {
        NavigationView {
            Form {
                TextLabelView(label: "Name", placeholder: "Server name", text: model.server.name)
                TextLabelView(label: "Address", placeholder: "Server address", text: model.server.address)
                TextLabelView(label: "Port", placeholder: "Server port", text: String(model.server.port))
            }
            .navigationBarTitle(Text(model.isNewServer ? "Add Server" : "Edit Server"), displayMode: .inline)
            .navigationBarItems(leading:
                Button("Cancel") {
                    logDebug(domain: .ui)
                    self.action?.dismiss()
                }, trailing:
                Button("Save") {
                    logDebug(domain: .ui)
                    self.action?.save(self.model.server)
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.accentStart)
    }
}

struct ServerEditView_Previews: PreviewProvider {
    static var previews: some View {
        Core.composer.serverCreateView()
            .previewStyle(.full)
    }
}
