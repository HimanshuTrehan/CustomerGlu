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

public struct OpenWallet: View {
    
    @State var token:String
    @State var fromUikit = false
    @State var my_url=""

    public init(cus_token:String,fromKit:Bool = false){
        token = cus_token
        fromUikit = fromKit
    }
  
   public var body: some View {
        VStack
        {
            if my_url=="" 
            {
                EmptyView()
            }
            else
            {
                CustomerWebView(my_url: my_url,fromWallet: true,fromUikit: false)
            }
        }
        .onAppear(perform: getCampaigns)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
   }
//    public func closeView()
//    {
//        self.presentationMode.wrappedValue.dismiss()
//    }
    
    
   
    public func getCampaigns()
     {
        
        CustomerGlu().retrieveData(customer_token: "") { CampaignsModel in
             my_url = CampaignsModel.defaultUrl
            print(my_url)
        }
     }
}
#endif
