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
    
    let UI_TESTING = true
    var dataManager: DataManagerProtocol!
    
    override func willActivate() {
        super.willActivate()
        
        self.dataManager = self.UI_TESTING ? MockDataManager() : DataManager()
    }
    
    override var body: LoginView {
        return LoginView(delegate: self)
    }
}

extension HostingController: LoginDelegate {
    func loginPressed(username: String, password: String, completion: @escaping (_ success: Bool, _ pick: PickModel?) -> Void) {
        let failureCompletion: () -> Void = { () in
            completion(false, nil)
        }
        
        let pickCompletion: (PickModel?) -> Void = { pick in
            if let pick = pick {
                completion(true, pick)
            } else {
                failureCompletion()
            }
        }
        
        let loginCompletion: (Bool) -> Void = { success in
            if success {
                self.dataManager.getNextPick { pick in
                    pickCompletion(pick)
                }
            } else {
                failureCompletion()
            }
        }
        
        self.dataManager.login(with: username, and: password, completion: loginCompletion)
    }
}
