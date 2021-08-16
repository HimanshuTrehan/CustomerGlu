//
//  SwiftUIView.swift
//  
//
//  Created by Himanshu Trehan on 24/07/21.
//

import SwiftUI
import UIKit
@available(iOS 13.0, *)

public struct OpenWallet: View {
    
    @State var token:String
    @State var my_url=""

    public init(cus_token:String){
        token = cus_token
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
                CustomerWebView(my_url: my_url,fromWallet: true)
            }
        }.onAppear(perform: getCampaigns)
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
        CustomerGlu().retrieveData(customer_token: token) { CampaignsModel in
             my_url = CampaignsModel.defaultUrl
            print(my_url)
        }
     }
}
