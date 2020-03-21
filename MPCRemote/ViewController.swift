//
//  ViewController.swift
//  MPCRemote
//
//  Created by doroshenko on 28.02.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        logDebug()
    }

    @IBAction func pingButtonClicked(_ sender: Any) {
        logDebug()

        guard let hostName = textInput.text else {
            logError("No host specified", domain: .default)
            UIAlertController(message: "No host specified", target: self)
            return
        }

        NetworkService.ping(hostName: hostName)
    }

    @IBAction func scanButtonClicked(_ sender: Any) {
        logDebug()

        NetworkService.scan()
    }

    @IBAction func cancelButtonClicked(_ sender: Any) {
        logDebug()

        NetworkService.cancel()
    }
}
