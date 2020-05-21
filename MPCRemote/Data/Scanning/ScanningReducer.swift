//
//  ScanningReducer.swift
//  MPCRemote
//
//  Created by doroshenko on 19.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

struct ScanningReducer: ReducerType {

    func reduce(_ dispatcher: Dispatcher, _ data: DataStore, _ action: ScanningAction) {
        switch action {
        case let .set(isScanning):
            data.isScanning = isScanning
        }
    }
}
