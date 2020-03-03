//
//  Connectivity.swift
//  MPCRemote
//
//  Created by doroshenko on 03.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

final class Connectivity {

    static var isConnectedToWifi: Bool {
        Reachability.forInternetConnection()?.currentReachabilityStatus() == ReachableViaWiFi
    }

    static func isHostReachable(hostName: String) -> Bool {
        Reachability(hostName: hostName)?.currentReachabilityStatus() != NotReachable
    }
}
