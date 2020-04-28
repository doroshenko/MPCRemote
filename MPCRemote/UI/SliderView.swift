//
//  SliderView.swift
//  MPCRemote
//
//  Created by doroshenko on 28.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerSlider: View {
    var value: Binding<Double>
    var range: ClosedRange<Double>
    var onEditingChanged: (Bool) -> Void

    var body: some View {
        Slider(value: value,
            in: range,
            step: 1,
            onEditingChanged: onEditingChanged)
    }
}

struct SeekSliderView: View {
    var value: Binding<Double>
    var range: ClosedRange<Double>
    var onEditingChanged: (Bool) -> Void

    var body: some View {
         PlayerSlider(value: value,
                      range: range,
                      onEditingChanged: onEditingChanged)
    }
}

 struct VolumeSliderView: View {
     var value: Binding<Double>
     var onEditingChanged: (Bool) -> Void

     var body: some View {
          PlayerSlider(value: value,
                       range: Parameter.Volume.range,
                       onEditingChanged: onEditingChanged)
     }
}

struct SliderView_Previews: PreviewProvider {

    @State private static var binding = Double(30)

    static var previews: some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            ZStack {
                Color(.systemBackground)
                VStack {
                    SeekSliderView(value: $binding, range: 0...60, onEditingChanged: { _ in })
                    VolumeSliderView(value: $binding, onEditingChanged: { _ in })
                }
            }
            .environment(\.colorScheme, scheme)
        }
    }
}
