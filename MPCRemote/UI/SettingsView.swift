//
//  ContentView.swift
//  SwiftUITest
//
//  Created by doroshenko on 19.04.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    @State private var address = String()
    @State private var showingAlert = false

    var body: some View {
        VStack(alignment: .center, spacing: 70) {
            Spacer()

            TextField("Address", text: $address)
                .padding([.leading, .trailing])
                .font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: saveAction) {
                Text("Save")
            }
            .font(.title)

            Button(action: pingAction) {
                Text("Ping")
            }
            .font(.title)

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
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("MPCRemote"), message: Text("No host specified"))
        })
        .onAppear(perform: {
            // TODO: better place to use this. Consider implementing Bindable UserDefaults integration
            self.address = StorageService.server?.address ?? NetworkService.defaultAddress ?? "192.168.1.1"
        })
    }
}

private extension SettingsView {

    func saveAction() {
        logDebug()
        guard validateAddress() else { return }
        StorageService.server = Server(address: address)
    }

    func pingAction() {
        logDebug()
        guard validateAddress() else { return }
        NetworkService.ping(hostName: address)
    }

    func scanAction() {
        logDebug()
        NetworkService.scan()
    }

    func cancelAction() {
        logDebug()
        NetworkService.cancel()
    }

    func validateAddress() -> Bool {
        guard !address.isEmpty else {
            logError("No host specified", domain: .default)
            showingAlert.toggle()
            return false
        }

        return true
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
