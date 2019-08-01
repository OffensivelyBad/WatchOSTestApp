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
                    .minimumScaleFactor(0.5)
                Rectangle()
                    .frame(width: 200, height: 1, alignment: .center)
                    .foregroundColor(Color.gray)
                Spacer()
                Text(pickStep == .lpn ? pick.shortLPN : "Scan SKU")
                    .font(.system(size: pickStep == .lpn ? 80 : 40))
                    .foregroundColor(pickStep == .lpn ? .yellow : .blue)
                    .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 60, idealHeight: nil, maxHeight: 60, alignment: .center)
                    .minimumScaleFactor(0.5)
                    .gesture(
                        LongPressGesture()
                            .onEnded { _ in
                                print("long pressed")
                        }
                    )
                Spacer()
                Rectangle()
                    .frame(width: 200, height: 1, alignment: .center)
                    .foregroundColor(Color.gray)
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

#if DEBUG
struct PickView_Previews : PreviewProvider {
    @State static var pick = PickModel(lpn: "LPN1234567890", sku: "098765-43-321", location: "B15-99-9-9A")
    @State static var pickStep = PickStep.lpn
    @State static var loggedIn = true
    
    static var previews: some View {
        Group {
            PickView(uiTesting: true, pick: $pick, pickStep: $pickStep, isLoggedIn: $loggedIn)
                .previewDevice("Apple Watch Series 4 - 44mm")
                .previewDisplayName("Apple Watch Series 4 - 44mm")
            
//            PickView(uiTesting: true, pick: $pick, pickStep: $pickStep, isLoggedIn: $loggedIn)
//                .previewDevice("Apple Watch Series 4 - 40mm")
//                .previewDisplayName("Apple Watch Series 4 - 40mm")
        }
    }
}
#endif
