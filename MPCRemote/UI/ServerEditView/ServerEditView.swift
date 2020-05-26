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
                TextLabelView(model: model.nameModel)
                TextLabelView(model: model.addressModel)
                TextLabelView(model: model.portModel)
            }
            .navigationBarTitle(Text(model.isNewServer ? "Add Server" : "Edit Server"), displayMode: .inline)
            .navigationBarItems(leading:
                Button("Cancel") {
                    logDebug(domain: .ui)
                    self.action?.dismiss()
                }, trailing:
                Button("Save") {
                    logDebug(domain: .ui)
                    self.action?.verify(address: self.model.addressModel.text, port: self.model.portModel.text, name: self.model.nameModel.text) { result in
                        self.model.nameModel.isInvalid = false
                        self.model.addressModel.isInvalid = false
                        self.model.portModel.isInvalid = false

                        switch result {
                        case let .success(server):
                            self.action?.save(server, editingServer: self.model.editingServer, isActive: self.model.isActiveServer)
                        case let .failure(error):
                            logDebug("Server verification error: \(error) ", domain: .ui)
                            switch error {
                            case .invalidName:
                                self.model.nameModel.isInvalid = true
                            case .invalidAddress:
                                self.model.addressModel.isInvalid = true
                            case .invalidPort:
                                self.model.portModel.isInvalid = true
                            }
                        }
                    }
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
