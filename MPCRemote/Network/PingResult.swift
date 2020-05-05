//
//  PingResult.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

typealias PingResult = Result<TimeInterval, PingError>
typealias PingHandler = (PingResult) -> Void
