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

    var body: some View {

        VStack(alignment: .leading) {
            Text(model.label)
                .font(.headline)
            TextField(model.placeholder, text: $model.text)
                .font(.body)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct TextLabelView_Previews: PreviewProvider {

    static var previews: some View {
        Core.composer.textLabelView()
            .previewStyle(.compact)
    }
}
