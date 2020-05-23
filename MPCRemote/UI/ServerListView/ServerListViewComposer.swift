//
//  ServerListViewComposer.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ServerListViewComposer: ComposerType {
    private let parent: Composer

    init(parent: Composer) {
        self.parent = parent
    }
}

extension ServerListViewComposer {

    func showServerCreateView() -> some View {
           parent.serverCreateView()
       }

    func showServerEditView(_ server: Server) -> some View {
        parent.serverEditView(server)
    }
}
