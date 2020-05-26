//
//  TextLabelView.swift
//  MPCRemote
//
//  Created by doroshenko on 23.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct TextLabelView: View {

    @ObservedObject var model: TextLabelViewModel
    let action: TextLabelViewActionCreatorType?

    var body: some View {

        VStack(alignment: .leading) {
            Text(model.label)
                .font(.headline)
            TextField(model.placeholder, text: $model.text, onEditingChanged: { _ in
                guard let isValid = self.action?.verify(self.model.text) else { return }
                self.model.isValid = isValid
            })
                .font(.body)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .border(model.isValid ? Color.accentStart : Color.red)
        }
    }
}

struct TextLabelView_Previews: PreviewProvider {

    static var previews: some View {
        Core.composer.textLabelAddressView()
            .previewStyle(.compact)
    }
}
