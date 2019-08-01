//
//  LoginView.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/5/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import SwiftUI

protocol LoginDelegate {
    func loginPressed(username: String, password: String, completion: @escaping (_ success: Bool, _ pick: PickModel?) -> Void)
    func bluetoothScanPressed()
}

struct LoginView : View {
    
    var delegate: LoginDelegate?
    @Binding var username: String
    @Binding var password: String
    @Binding var loading: Bool
    @Binding var isLoggedIn: Bool
    @Binding var pick: PickModel
    @Binding var pickStep: PickStep
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                TextField("username", text: $username)
                SecureField("password", text: $password)
                Button(action: {
                    self.delegate?.bluetoothScanPressed()
                })
                {
                    Text("Scan Bluetooth")
                }
                Button(action: {
                    self.loading.toggle()
                    self.delegate?.loginPressed(username: self.username, password: self.password, completion: { (success, pick) in
                        self.afterLogin(success: success, pick: pick)
                    })
                })
                {
                    Text(self.loading ? "Logging in..." : "Login")
                }
                .disabled(self.loading)
                .opacity(self.loading ? 0.5 : 1.0)
            }
        }
    }
    
    private func afterLogin(success: Bool, pick: PickModel?) {
        guard success, let pick = pick else { self.loading.toggle(); return }
        self.isLoggedIn.toggle()
        self.pick = pick
        self.pickStep = .lpn
    }
    
}

#if DEBUG
struct LoginView_Previews : PreviewProvider {
    @State static var username = ""
    @State static var password = ""
    @State static var loading = false
    @State static var isLoggedIn = false
    @State static var pick = PickModel(lpn: "LPN5555500000", sku: "55555-22-11", location: "C15-01-1-1A")
    @State static var pickStep = PickStep.lpn
    
    static var previews: some View {
        Group {
            LoginView(delegate: nil, username: $username, password: $password, loading: $loading, isLoggedIn: $isLoggedIn, pick: $pick, pickStep: $pickStep)
                .previewDevice("Apple Watch Series 4 - 44mm")
                .previewDisplayName("Apple Watch Series 4 - 44mm")
            
            LoginView(delegate: nil, username: $username, password: $password, loading: $loading, isLoggedIn: $isLoggedIn, pick: $pick, pickStep: $pickStep)
                .previewDevice("Apple Watch Series 4 - 40mm")
                .previewDisplayName("Apple Watch Series 4 - 40mm")
        }
    }
}
#endif

