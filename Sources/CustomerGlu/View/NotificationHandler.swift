//
//  File.swift
//  
//
//  Created by Himanshu Trehan on 29/08/21.
//

import Foundation


//
//  SwiftUIView.swift
//
//
//  Created by Himanshu Trehan on 24/07/21.
//
#if canImport(SwiftUI)

import SwiftUI
import UIKit
@available(iOS 13.0, *)

public struct NotificationHandler: View {
    
    @State var fromUikit = false
   // @State var my_url:String

    public init(fromKit:Bool = false){
    //    my_url = nudge_url
        fromUikit = fromKit
    }
  
   public var body: some View {
        VStack
        {
//            if my_url==""
//            {
//                EmptyView()
//            }
//            else
//            {
                CustomerWebView(my_url: "https://google.com",fromWallet: true,fromUikit: true)
           // }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
   }

    

}
#endif
