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
                VStack {
                    Spacer()
                    Text(location)
                        .font(.title)
                    Spacer()
                    HStack {
                        Text(self.shortLPN(from: lpn))
                            .font(.system(size: 80))
                            .color(.yellow)
                    }
                    Spacer()
                }
            } else {
                VStack {
                    Spacer()
                    TextField($username, placeholder: Text("username"))
                    TextField($password, placeholder: Text("password"))
                    Button(action: {
                        self.delegate?.loginPressed(username: self.username, password: self.password, completion: { (complete, lpn, location) in
                            self.isLoggedIn.toggle()
                            self.lpn = lpn ?? ""
                            self.location = location ?? ""
                        })
                    })
                    {
                        Text("Login")
                    }
                }
            }
        }
    }
    
    func shortLPN(from lpn: String) -> String {
        return String(lpn.suffix(4))
    }
    
    
}

#if DEBUG
struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
