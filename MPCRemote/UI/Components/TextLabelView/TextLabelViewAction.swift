//
//  TextLabelViewAction.swift
//  MPCRemote
//
//  Created by doroshenko on 26.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol TextLabelViewActionCreatorType: ActionCreatorType {
    func verify(_ value: String) -> Bool
}

struct TextLabelAddressViewActionCreator: TextLabelViewActionCreatorType {

    private let provider: ServerListProviderType

    init(provider: ServerListProviderType) {
        self.provider = provider
    }

    func verify(_ value: String) -> Bool {
        logDebug("Verifying server address: \(value)", domain: .ui)
        return provider.verify(address: value) != nil
    }
}

struct TextLabelPortViewActionCreator: TextLabelViewActionCreatorType {

    private let provider: ServerListProviderType

    init(provider: ServerListProviderType) {
        self.provider = provider
    }

    func verify(_ value: String) -> Bool {
        logDebug("Verifying server port: \(value)", domain: .ui)
        return provider.verify(port: value) != nil
    }
}

struct TextLabelNameViewActionCreator: TextLabelViewActionCreatorType {

    private let provider: ServerListProviderType

    init(provider: ServerListProviderType) {
        self.provider = provider
    }

    func verify(_ value: String) -> Bool {
        logDebug("Verifying server name: \(value)", domain: .ui)
        return provider.verify(name: value) != nil
    }
}
