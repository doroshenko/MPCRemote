//
//  SliderView.swift
//  MPCRemote
//
//  Created by doroshenko on 28.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct SliderView: View {
    @ObservedObject private(set) var model: SliderViewModel<Double>

    let action: SliderViewActionCreatorType?
    let composer: SliderViewComposer?

    private var range: ClosedRange<Double> {
        0...model.maxValue.clamped(to: 1...)
    }

    var body: some View {
        VStack {
            HStack {
                Text(model.formattedDescription(model.value))
                Spacer()
                Text(model.formattedDescription(model.maxValue))
            }
            Slider(value: $model.value,
            in: range,
            step: 1,
            onEditingChanged: { isEditing in
                self.action?.set(isEditing)

                if !isEditing {
                    self.action?.post(self.model.formattedValue)
                }
            })
             .disabled(model.maxValue == 0)
        }
    }
}

//
//struct SliderView_Previews: PreviewProvider {
//
//    @State private static var binding = Double(30)
//    private static let duration: Double = 60
//
//    static var previews: some View {
//        VStack {
//            SeekSliderView(position: $binding, duration: duration, onEditingChanged: { _ in })
//            VolumeSliderView(volume: $binding, onEditingChanged: { _ in })
//        }
//        .previewStyle(.compact)
//    }
//}
