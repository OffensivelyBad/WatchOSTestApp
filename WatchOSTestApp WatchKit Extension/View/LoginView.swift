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
}

struct LoginView : View {
    var delegate: LoginDelegate?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loading: Bool = false
    @State private var isLoggedIn: Bool = false
    @State private var pick: PickModel = PickModel(lpn: "", sku: "", location: "")
    
    var body: some View {
        ZStack {
            if isLoggedIn {
                PickView(pick: $pick)
            } else {
                VStack {
                    Spacer()
                    TextField($username, placeholder: Text("username"))
                    SecureField($password, placeholder: Text("password"))
                    Button(action: {
                        self.loading.toggle()
                        self.delegate?.loginPressed(username: self.username, password: self.password, completion: { (success, pick) in
                            guard success, let pick = pick else { self.loading.toggle(); return }
                            self.isLoggedIn.toggle()
                            self.pick = pick
                        })
                    })
                    {
                        Text(self.loading ? "Logging in..." : "Login")
                    }
                    .disabled(self.loading)
                    .opacity(self.loading ? 0.5 : 1)
                }
            }
        }
    }
    
    
}

