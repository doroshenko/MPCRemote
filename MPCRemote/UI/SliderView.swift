//
//  SliderView.swift
//  MPCRemote
//
//  Created by doroshenko on 28.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct SeekSliderView: View {

    var value: Binding<Double>
    var onEditingChanged: (Bool) -> Void

    var body: some View {
        Slider(value: value,
               in: Parameter.Seek.range.doubleRange,
               step: 1,
               onEditingChanged: onEditingChanged)
    }
}

struct VolumeSliderView: View {
    var value: Binding<Double>
    var onEditingChanged: (Bool) -> Void

    var body: some View {
        Slider(value: value,
               in: Parameter.Volume.range.doubleRange,
               step: 1,
               onEditingChanged: onEditingChanged)
    }
}
