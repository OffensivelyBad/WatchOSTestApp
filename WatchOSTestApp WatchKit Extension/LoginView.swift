//
//  LoginView.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/5/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import SwiftUI

protocol LoginDelegate {
    func loginPressed(username: String, password: String, completion: @escaping (Bool, String?, String?) -> Void)
}

struct LoginView : View {
    var delegate: LoginDelegate?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loading: Bool = false
    @State private var isLoggedIn: Bool = false
    @State private var lpn: String = ""
    @State private var location: String = ""
    
    var body: some View {
        ZStack {
            if isLoggedIn {
                LPNView(location: $location, lpn: $lpn)
            } else {
                VStack {
                    Spacer()
                    TextField($username, placeholder: Text("username"))
                    SecureField($password, placeholder: Text("password"))
                    Button(action: {
                        self.loading.toggle()
                        self.delegate?.loginPressed(username: self.username, password: self.password, completion: { (success, lpn, location) in
                            if success {
                                self.isLoggedIn.toggle()
                                self.lpn = lpn ?? ""
                                self.location = location ?? ""
                            } else {
                                self.loading.toggle()
                            }
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

#if DEBUG
struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
