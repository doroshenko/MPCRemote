//
//  Array+UpdateOrAppend.swift
//  MPCRemote
//
//  Created by doroshenko on 11.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

extension Array where Element: Identifiable {

    mutating func updateOrAppend(_ newElement: Element) {
        if let index = firstIndex(where: { $0.id == newElement.id }) {
            self[index] = newElement
        } else {
            append(newElement)
        }
    }
}
