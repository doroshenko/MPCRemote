//
//  SliderView.swift
//  MPCRemote
//
//  Created by doroshenko on 28.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct SeekSliderView: View {
    @Binding var position: Double
    let duration: Double
    @State var onEditingChanged: (Bool) -> Void

    private var range: ClosedRange<Double> {
        0...duration.clamped(to: 1...)
    }

    var body: some View {
        VStack {
            HStack {
                Text(position.seekDescription)
                Spacer()
                Text(duration.seekDescription)
            }
            Slider(value: $position,
                   in: range,
                   step: 1,
                   onEditingChanged: onEditingChanged)
        }
    }
}

struct VolumeSliderView: View {
    @Binding var volume: Double
    @State var onEditingChanged: (Bool) -> Void

    var body: some View {
        Slider(value: $volume,
               in: Parameter.Volume.range,
               step: 1,
               onEditingChanged: onEditingChanged)
    }
}

struct SliderView_Previews: PreviewProvider {

    @State private static var binding = Double(30)
    private static let duration: Double = 60

    static var previews: some View {
        VStack {
            SeekSliderView(position: $binding, duration: duration, onEditingChanged: { _ in })
            VolumeSliderView(volume: $binding, onEditingChanged: { _ in })
        }
        .previewStyle(.compact)
    }
}
