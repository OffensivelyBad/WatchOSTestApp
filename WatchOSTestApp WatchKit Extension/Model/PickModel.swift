//
//  PickModel.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/9/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import Foundation

struct PickModel {
    var lpn: String
    var sku: String
    var location: String
    var shortLPN: String {
        return String(self.lpn.suffix(4))
    }
}
