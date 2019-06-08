//
//  LPNView.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/8/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import SwiftUI

struct LPNView : View {
    @Binding var location: String
    @Binding var lpn: String
    
    var body: some View {
        VStack {
            Text(location)
                .font(.title)
            Text(self.shortLPN(from: lpn))
                .font(.system(size: 80))
                .color(.yellow)
            Text(lpn)
                .font(.footnote)
        }
    }
    
    func shortLPN(from lpn: String) -> String {
        return String(lpn.suffix(4))
    }
}
