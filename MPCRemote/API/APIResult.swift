//
//  APIResult.swift
//  MPCRemote
//
//  Created by doroshenko on 05.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import UIKit

typealias APIResult<Value> = Result<Value, APIError>
typealias APIHandler<Value> = (APIResult<Value>) -> Void

typealias PostResult = APIResult<Void>
typealias PostHandler = APIHandler<Void>

typealias StateResult = APIResult<PlayerState>
typealias StateHandler = APIHandler<PlayerState>

typealias SnapshotResult = APIResult<UIImage>
typealias SnapshotHandler = APIHandler<UIImage>

typealias ServerResult = APIResult<Server>
typealias ServerHandler = APIHandler<Server>
