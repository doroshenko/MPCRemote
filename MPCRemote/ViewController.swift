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

        logTrace()
    }

    @IBAction func pingButtonClicked(_ sender: Any) {
        logTrace()

        guard let hostName = textInput.text else {
            logError("No host specified", domain: .default)
            UIAlertController(message: "No host specified", target: self)
            return
        }

        let scanner = NetworkScanner()
        scanner.ping(hostName: hostName)
    }

    @IBAction func scanButtonClicked(_ sender: Any) {
        logTrace()

        let scanner = NetworkScanner()
        scanner.scan()
    }

    @IBAction func cancelButtonClicked(_ sender: Any) {
        logTrace()

        let scanner = NetworkScanner()
        scanner.cancel()
    }
}
