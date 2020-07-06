//
//  Connectivity.swift
//  MPCRemote
//
//  Created by doroshenko on 03.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Alamofire

enum Connectivity {

    static var isConnectedToWifi: Bool {
        NetworkReachabilityManager()?.isReachableOnEthernetOrWiFi == true
    }

    static func isHostReachable(hostName: String) -> Bool {
        NetworkReachabilityManager(host: hostName)?.isReachable == true
    }

    static var localIPAddress: (address: String?, mask: String?) {
        let wifiInterface = "en0"
        var address: String?
        var mask: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?

        guard getifaddrs(&ifaddr) == 0 else {
            return (address: address, mask: mask)
        }

        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next }

            guard let interface = ptr?.pointee,
                interface.ifa_addr.pointee.sa_family == UInt8(AF_INET), // IPv6 is useless for scanning purposes and therefore excluded
                String(cString: (interface.ifa_name)) == wifiInterface else { continue }

            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
            address = String(cString: hostname)

            var netmask = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            getnameinfo(interface.ifa_netmask, socklen_t(interface.ifa_netmask.pointee.sa_len), &netmask, socklen_t(netmask.count), nil, socklen_t(0), NI_NUMERICHOST)
            mask = String(cString: netmask)
        }
        freeifaddrs(ifaddr)

        return (address: address, mask: mask)
    }
}
