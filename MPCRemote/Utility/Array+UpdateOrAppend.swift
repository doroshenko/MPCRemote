//
//  Array+UpdateOrAppend.swift
//  MPCRemote
//
//  Created by doroshenko on 11.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

// TODO: cleanup. fix unit tests

extension Array where Element == Server {

    mutating func appendUnique(_ newElement: Element) {
        if let index = firstIndex(where: { $0.id == newElement.id }) {
            self[index] = newElement
        } else {
            append(newElement)
        }
    }
}

extension Array where Element == ServerListItem {

    mutating func updateOrAppend(_ newElement: Element, overwrite: Bool) {
        if let index = firstIndex(where: { $0.id == newElement.id }) {
            let updatedElement = ServerListItem(server: self[index].server,
                                                isFavorite: self[index].isFavorite,
                                                isOnline: newElement.isOnline)
            self[index] = overwrite ? newElement : updatedElement
        } else {
            append(newElement)
        }
    }
}
