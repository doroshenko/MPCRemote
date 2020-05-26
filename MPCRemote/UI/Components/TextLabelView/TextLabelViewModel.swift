//
//  TextLabelViewModel.swift
//  MPCRemote
//
//  Created by doroshenko on 25.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol TextLabelViewModelType {
    var label: String { get }
    var placeholder: String { get }
    var text: String { get set }
}

class TextLabelViewModel: TextLabelViewModelType, ObservableObject {

    private(set) var label: String
    private(set) var placeholder: String
    @Published var text: String

    init(_ text: String?) {
        self.label = ""
        self.placeholder = ""
        self.text = text ?? ""
    }
}

final class TextLabelAddressViewModel: TextLabelViewModel {

    override var label: String {
        "Address"
    }

    override var placeholder: String {
        "Server address"
    }

    init(_ serverListItem: ServerListItem?) {
        super.init(serverListItem?.server.address)
    }
}

final class TextLabelPortViewModel: TextLabelViewModel {

    override var label: String {
        "Port"
    }

    override var placeholder: String {
        "Server port"
    }

    init(_ serverListItem: ServerListItem?) {
        super.init(String(serverListItem?.server.port ?? Port.default))
    }
}

final class TextLabelNameViewModel: TextLabelViewModel {

    override var label: String {
        "Name"
    }

    override var placeholder: String {
        "Server name"
    }

    init(_ serverListItem: ServerListItem?) {
        super.init(serverListItem?.server.name)
    }
}
