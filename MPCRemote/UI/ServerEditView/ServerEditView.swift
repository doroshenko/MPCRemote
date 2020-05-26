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
                composer?.textLabelNameView(model.nameModel)
                composer?.textLabelAddressView(model.addressModel)
                composer?.textLabelPortView(model.portModel)
            }
            .navigationBarTitle(Text(model.isNewServer ? "Add Server" : "Edit Server"), displayMode: .inline)
            .navigationBarItems(leading:
                Button("Cancel") {
                    logDebug(domain: .ui)
                    self.action?.dismiss()
                }, trailing:
                Button("Save") {
                    logDebug(domain: .ui)
                    guard let server = self.action?.verify(address: self.model.addressModel.text,
                                                           port: self.model.portModel.text,
                                                           name: self.model.nameModel.text) else {
                        return
                    }

                    self.action?.save(server, editingServer: self.model.editingServer, isActive: self.model.isActiveServer)
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.accentStart)
    }
}

struct ServerEditView_Previews: PreviewProvider {
    static var previews: some View {
        Core.composer.serverEditView()
            .previewStyle(.full)
    }
}
