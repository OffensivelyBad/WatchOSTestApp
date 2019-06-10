//
//  PickView.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/8/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import SwiftUI

struct PickView : View {
    @Binding var pick: PickModel
    
    var body: some View {
        VStack {
            Text(pick.location)
                .font(.title)
            Text(pick.shortLPN)
                .font(.system(size: 80))
                .color(.yellow)
            Text(pick.lpn)
                .font(.footnote)
        }
    }
}
