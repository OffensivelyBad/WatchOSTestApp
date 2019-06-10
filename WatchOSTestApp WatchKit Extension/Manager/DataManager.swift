//
//  DataManager.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/9/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    func login(with username: String, and password: String, completion: @escaping (_ success: Bool) -> Void)
    func getNextPick(completion: @escaping (_ pick: PickModel?) -> Void)
}

struct DataManager: DataManagerProtocol {
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    func getNextPick(completion: @escaping (PickModel?) -> Void) {
        
    }
    
}
