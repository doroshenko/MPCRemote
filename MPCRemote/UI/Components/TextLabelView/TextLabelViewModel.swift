//
//  TextLabelViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 25.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

class TextLabelViewModel: ObservableObject {

    private(set) var label: String
    private(set) var placeholder: String
    @Published var text: String

    init(_ text: String?) {
        self.text = text ?? ""
        self.label = ""
        self.placeholder = ""
    }
}

final class TextLabelNameViewModel: TextLabelViewModel {

    override var label: String {
        "Name"
    }

    override var placeholder: String {
        "Server name"
    }

    init(_ server: Server?) {
        super.init(server?.name)
    }
}

final class TextLabelAddressViewModel: TextLabelViewModel {

    override var label: String {
        "Address"
    }

    override var placeholder: String {
        "Server address"
    }

    init(_ server: Server?) {
        super.init(server?.address)
    }
}

final class TextLabelPortViewModel: TextLabelViewModel {

    override var label: String {
        "Port"
    }

    override var placeholder: String {
        "Server port"
    }

    init(_ server: Server?) {
        super.init(String(server?.port ?? Port.default))
    }
}
