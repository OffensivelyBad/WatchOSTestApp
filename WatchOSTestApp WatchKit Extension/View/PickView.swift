//
//  PickView.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/8/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import SwiftUI

enum PickStep {
    case lpn, sku
}

struct PickView : View {
    var uiTesting: Bool
    @Binding var pick: PickModel
    @Binding var pickStep: PickStep
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Text(pick.location)
                    .font(.system(size: 25))
                Spacer()
                Text(pickStep == .lpn ? pick.shortLPN : "Scan SKU")
                    .font(.system(size: pickStep == .lpn ? 80 : 40))
                    .color(pickStep == .lpn ? .yellow : .blue)
                    .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 90, idealHeight: nil, maxHeight: 90, alignment: .center)
                    .minimumScaleFactor(0.5)
                Spacer()
                Text(pickStep == .lpn ? pick.lpn : pick.sku)
                    .font(.system(size: 22))
                    .minimumScaleFactor(0.5)
                if self.uiTesting {
                    Button(action: {
                        self.pickStep = self.pickStep == .lpn ? .sku : .lpn
                    })
                    {
                        Text("Scan Sim")
                    }
                }
                Button(action: {
                    self.pickStep = .lpn
                })
                {
                    Text("Skip")
                }
                Button(action: {
                    self.isLoggedIn = false
                })
                {
                    Text("Done")
                }
            }
        }
    }
}
