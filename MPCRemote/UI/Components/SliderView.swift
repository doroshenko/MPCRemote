//
//  SliderView.swift
//  MPCRemote
//
//  Created by doroshenko on 28.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct PlayerSlider: View {
    var getter: () -> Double
    var setter: (Double) -> Void
    var range: ClosedRange<Double>

    @State private var isEditing: Bool = false
    @State private var result: Double = 0

    private var value: Binding<Double> {
        Binding<Double>(get: {
            guard !self.isEditing else { return self.result }
            return self.getter()
        }, set: { newValue in
            self.result = newValue
        })
    }

    var body: some View {
        Slider(value: value,
               in: range,
               step: 1,
               onEditingChanged: { isEditing in
                self.isEditing = isEditing

                guard !isEditing else { return }
                self.setter(self.result)
        })
    }
}

struct SeekSliderView: View {
    var getter: () -> Double
    var setter: (Double) -> Void
    var range: ClosedRange<Double>

    private func seekValue(_ value: Double) -> Double {
        value * Parameter.Seek.range.upperBound / range.upperBound
    }

    var body: some View {
        PlayerSlider(getter: getter,
                     setter: { newValue in
                        self.setter(self.seekValue(newValue))
        },
                     range: range)
    }
}

struct VolumeSliderView: View {
     var getter: () -> Double
     var setter: (Double) -> Void

     var body: some View {
          PlayerSlider(getter: getter,
                       setter: setter,
                       range: Parameter.Volume.range)
     }
}

struct SliderView_Previews: PreviewProvider {

    @State private static var binding = Double(30)

    static var previews: some View {
        VStack {
            SeekSliderView(getter: { 30 }, setter: { _ in }, range: 0...60)
            VolumeSliderView(getter: { 30 }, setter: { _ in })
        }
        .previewStyle(.compact)
    }
}
