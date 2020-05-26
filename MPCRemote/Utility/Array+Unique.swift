//
//  Array+Unique.swift
//  MPCRemote
//
//  Created by doroshenko on 11.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

extension Array where Element: Identifiable {

    mutating func appendUnique(_ newElement: Element) {
        if let index = firstIndex(where: { $0.id == newElement.id }) {
            self[index] = newElement
        } else {
            append(newElement)
        }
    }
}

extension Array where Element == ServerListItem {

    mutating func updateUnique(_ newElement: Element) {
        if let index = firstIndex(where: { $0.id == newElement.id }) {
            let updatedElement = ServerListItem(server: self[index].server,
                                                isFavorite: self[index].isFavorite,
                                                isOnline: newElement.isOnline)
            self[index] = updatedElement
        } else {
            append(newElement)
        }
    }
}
