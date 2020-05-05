//
//  Comparable+Clamped.swift
//  MPCRemote
//
//  Created by doroshenko on 10.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }

    func clamped(to range: PartialRangeFrom<Self>) -> Self {
        max(self, range.lowerBound)
    }
}

extension ClosedRange where Bound == Int {
    var doubleRange: ClosedRange<Double> {
        Double(lowerBound)...Double(upperBound)
    }
}
