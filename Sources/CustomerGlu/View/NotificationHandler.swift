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
    @State var ismiddle = false
  
    var body: some View {
        VStack
        {
            if my_url==""
            {
                EmptyView()
                
            }
            else
            {
                if ismiddle
                {
                    ZStack
                    {
                        // PopUp background color
                                       Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)

                                       // PopUp Window
                                       VStack(alignment: .center, spacing: 0) {
                                        CustomerWebView(my_url: my_url,fromWallet: true,fromUikit: true)

                                       }
                                       .frame(maxWidth: 300,maxHeight: 300)
                                       .border(Color.white, width: 2)
                                   //    .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
                                   }
                    }
                
                else
                {
                CustomerWebView(my_url: my_url,fromWallet: true,fromUikit: true)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
   }

    

}
#endif
