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
    @Binding var pickStep: PickStep
    
    var body: some View {
        VStack {
            Text(pick.location)
                .font(.system(size: 25))
            Spacer()
            Text(pickStep == .lpn ? pick.shortLPN : "Scan SKU")
                .font(.system(size: pickStep == .lpn ? 80 : 40))
                .color(pickStep == .lpn ? .yellow : .blue)
            Spacer()
            Text(pickStep == .lpn ? pick.lpn : pick.sku)
                .font(.footnote)
        }
    }
}
