//
//  MockDataManager.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/9/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import Foundation

struct MockDataManager: DataManagerProtocol {
    
    func login(with username: String, and password: String, completion: @escaping (_ success: Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion(true)
        }
    }
    
    func getPickList(completion: @escaping (_ success: Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion(true)
        }
    }
    
    func getNextPick(completion: @escaping (_ success: Bool, _ pick: PickModel?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let pick = PickModel(lpn: "LPN1234567890", sku: "12345-67-890", location: "A88-08-8-8A")
            completion(true, pick)
        }
    }
    
    func pickExists(pickID: Int, completion: @escaping (_ success: Bool, _ exists: Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion(true, true)
        }
    }
    
    func pick(pick: PickModel, completion: @escaping (_ success: Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion(true)
        }
    }
    
    func skipPick(pickID: Int, location: String, completion: @escaping (_ success: Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion(true)
        }
    }
    
    func donePicking(completion: @escaping (_ success: Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            completion(true)
        }
    }
    
}
