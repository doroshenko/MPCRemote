//
//  TextLabelView.swift
//  MPCRemote
//
//  Created by doroshenko on 23.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct TextLabelView: View {
    var label: String
    var placeholder: String
    @State var text = String()

    var body: some View {

        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField(placeholder, text: $text)
                .font(.body)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct TextLabelView_Previews: PreviewProvider {
    static var previews: some View {
        TextLabelView(label: "Label", placeholder: "Placeholder")
            .previewStyle(.compact)
    }
}
