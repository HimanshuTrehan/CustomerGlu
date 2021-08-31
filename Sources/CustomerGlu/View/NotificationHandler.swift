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

 struct NotificationHandler: View {
    
    @State var fromUikit = false
    @State var my_url:String

  
    var body: some View {
        VStack
        {
        
                CustomerWebView(my_url: my_url,fromWallet: true,fromUikit: true)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
   }

    

}
#endif
