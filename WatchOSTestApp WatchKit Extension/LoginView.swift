//
//  LoginView.swift
//  WatchOSTestApp WatchKit Extension
//
//  Created by Shawn Roller on 6/5/19.
//  Copyright © 2019 Shawn Roller. All rights reserved.
//

import SwiftUI

protocol LoginDelegate {
    func loginPressed(username: String, password: String, completion: @escaping (Bool, String?) -> Void)
}

struct LoginView : View {
    var delegate: LoginDelegate?
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loading: Bool = false
    @State private var isLoggedIn: Bool = false
    @State private var lpn: String = ""
    
    var body: some View {
        ZStack {
            if isLoggedIn {
                VStack {
                    Text("Scan LPN")
                        .font(.largeTitle)
                    HStack {
                        Text(lpn)
                            .font(.body)
                            .color(.yellow)
                    }
                }
            } else {
                VStack {
                    TextField($username, placeholder: Text("username"))
                    TextField($password, placeholder: Text("password"))
                    Button(action: {
                        self.delegate?.loginPressed(username: self.username, password: self.password, completion: { (complete, lpn) in
                            self.isLoggedIn.toggle()
                            self.lpn = lpn ?? ""
                        })
                    })
                    {
                        Text("Login")
                    }
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
