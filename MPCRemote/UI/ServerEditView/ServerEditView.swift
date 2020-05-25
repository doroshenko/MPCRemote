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
                    // TODO: validation
                    let server = Server(address: self.model.addressModel.text, port: UInt16(self.model.portModel.text)!, name: self.model.nameModel.text)
                    self.action?.save(server)
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
