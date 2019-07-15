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
    func getPickList(completion: @escaping (_ success: Bool) -> Void)
    func getNextPick(completion: @escaping (_ success: Bool, _ pick: PickModel?) -> Void)
    func pickExists(pickID: Int, completion: @escaping (_ success: Bool, _ exists: Bool) -> Void)
    func pick(pick: PickModel, completion: @escaping (_ success: Bool) -> Void)
    func skipPick(pickID: Int, location: String, completion: @escaping (_ success: Bool) -> Void)
    func donePicking(completion: @escaping (_ success: Bool) -> Void)
}

struct DataManager: DataManagerProtocol {
    
    func login(with username: String, and password: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    func getPickList(completion: @escaping (_ success: Bool) -> Void) {
        
    }
    
    func getNextPick(completion: @escaping (_ success: Bool, _ pick: PickModel?) -> Void) {
        
    }
    
    func pickExists(pickID: Int, completion: @escaping (_ success: Bool, _ exists: Bool) -> Void) {
        
    }
    
    func pick(pick: PickModel, completion: @escaping (_ success: Bool) -> Void) {
        
    }
    
    func skipPick(pickID: Int, location: String, completion: @escaping (_ success: Bool) -> Void) {
        
    }
    
    func donePicking(completion: @escaping (_ success: Bool) -> Void) {
        
    }
    
}
