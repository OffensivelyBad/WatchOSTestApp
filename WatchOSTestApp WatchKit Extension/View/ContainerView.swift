//
//  ContainerView.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 7/12/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import SwiftUI

struct ContainerView : View {
    
    var uiTesting: Bool
    var delegate: LoginDelegate?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loading: Bool = false
    @State private var isLoggedIn: Bool = false
    @State private var pick: PickModel = PickModel(lpn: "", sku: "", location: "")
    @State private var pickStep: PickStep = .lpn
    
    var body: some View {
        ZStack {
            if isLoggedIn {
                PickView(pick: $pick, pickStep: $pickStep)
                if self.uiTesting {
                    Button(action: {
                        self.pickStep = self.pickStep == .lpn ? .sku : .lpn
                    })
                    {
                        Text("Scan Sim")
                    }
                }
            } else {
                LoginView(delegate: self.delegate, username: $username, password: $password, loading: $loading, isLoggedIn: $isLoggedIn, pick: $pick, pickStep: $pickStep)
            }
        }
    }
}
//
//#if DEBUG
//struct ContainerView_Previews : PreviewProvider {
//    static var previews: some View {
//        ContainerView()
//    }
//}
//#endif
