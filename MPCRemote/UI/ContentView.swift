//
//  ContentView.swift
//  SwiftUITest
//
//  Created by doroshenko on 19.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var addressText: String = "192.168.1.1"
    @State private var showingAlert = false

    var body: some View {
        VStack(alignment: .center, spacing: 70) {
            Spacer()

            TextField("IP address", text: $addressText)
                .frame(width: 200, alignment: .center)
                .font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: pingAction) {
                Text("Ping")
            }
            .font(.title)
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("MPC Remote"), message: Text("No host specified"))
            })

            Button(action: scanAction) {
                Text("Scan")
            }
            .font(.title)

            Button(action: cancelAction) {
                Text("Cancel")
            }
            .font(.title)

            Spacer()
        }
    }

    func pingAction() {
        logDebug()

        guard !addressText.isEmpty else {
            logError("No host specified", domain: .default)
            showingAlert.toggle()
            return
        }

        NetworkService.ping(hostName: addressText)
    }

    func scanAction() {
        logDebug()

        NetworkService.scan()
    }

    func cancelAction() {
        logDebug()

        NetworkService.cancel()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
