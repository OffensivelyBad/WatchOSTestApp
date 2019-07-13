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
    @State private var isLoggedIn: Bool = true
    @State private var pick: PickModel = PickModel(lpn: "LPN1234567890", sku: "12345-67-890", location: "A15-01-1-1A")
    @State private var pickStep: PickStep = .lpn
    
    var body: some View {
        ZStack {
            if isLoggedIn {
                PickView(uiTesting: uiTesting, pick: $pick, pickStep: $pickStep, isLoggedIn: $isLoggedIn)
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
