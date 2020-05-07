//
//  TimerHolder.swift
//  MPCRemote
//
//  Created by doroshenko on 07.05.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

protocol TimerHolderType {
    func schedule(completion: @escaping () -> Void)
    func cancel()
}

final class TimerHolder: TimerHolderType {

    private var timer: Timer?

    func schedule(completion: @escaping () -> Void) {
        cancel()
        timer = Timer.scheduledTimer(withTimeInterval: .fetch, repeats: false, block: { _ in
            completion()
        })
    }

    func cancel() {
        timer?.invalidate()
        timer = nil
    }
}
