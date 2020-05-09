//
//  DataStore.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

final class DataStore: ObservableObject {
    @Published var playerState = PlayerState()
    @Published var sliderState = SliderState()
    @Published var serverList = [Server]()
}
