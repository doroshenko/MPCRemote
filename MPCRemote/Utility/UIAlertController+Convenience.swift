//
//  UIAlertController+Convenience.swift
//  MPCRemote
//
//  Created by doroshenko on 01.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import UIKit

extension UIAlertController {

    @discardableResult
    convenience init(title: String = "MPCRemote", message: String, buttonTitle: String = "OK", target: UIViewController) {
        self.init(title: title, message: message, preferredStyle: .alert)

        addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        target.present(self, animated: true, completion: nil)

        logTrace("Alert shown with message: \(title) from controller: \(target)", domain: .default)
    }
}
