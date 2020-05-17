//
//  AddServerButton.swift
//  MPCRemote
//
//  Created by doroshenko on 18.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct AddServerButton: View {

    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: Constants.size, height: Constants.size)
                .foregroundColor(Color.accentStart)
                .shadow(color: Color.shadowEnd, radius: Constants.Shadow.radius, x: Constants.Shadow.normal, y: Constants.Shadow.normal)
        })
        .padding()
    }
}

private struct Constants {

    static let size: CGFloat = 60

    enum Shadow {
        static let normal: CGFloat = 2
        static let radius: CGFloat = 6
    }
}
