//
//  HostingController.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/5/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController : WKHostingController<LoginView> {
    override var body: LoginView {
        return LoginView(delegate: self)
    }
}

extension HostingController: LoginDelegate {
    func loginPressed(username: String, password: String, completion: @escaping (Bool, String?, String?) -> Void) {
        print("\(username) \(password)")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion(true, "LPN1234567890", "A15-01-1-1")
        }
    }
}
