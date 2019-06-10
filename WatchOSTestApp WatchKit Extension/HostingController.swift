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
    func loginPressed(username: String, password: String, completion: @escaping (_ success: Bool, _ location: String?, _ lpn: String?) -> Void) {
        let failureCompletion: () -> Void = { () in
            completion(false, nil, nil)
        }
        
        let pickCompletion: (String?, String?) -> Void = { (location, lpnString) in
            if let loc = location, let lpn = lpnString {
                completion(true, loc, lpn)
            } else {
                failureCompletion()
            }
        }
        
        let loginCompletion: (Bool) -> Void = { success in
            if success {
                self.getNextPick { (location, lpn) in
                    pickCompletion(location, lpn)
                }
            } else {
                failureCompletion()
            }
        }
        
        self.login(with: username, and: password, completion: loginCompletion)
    }
    
    private func login(with username: String, and password: String, completion: @escaping (_ success: Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion(true)
        }
    }
    
    private func getNextPick(completion: @escaping (_ location: String?, _ lpn: String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion("A15-08-8-8", "LPN0987654321")
        }
    }
}
