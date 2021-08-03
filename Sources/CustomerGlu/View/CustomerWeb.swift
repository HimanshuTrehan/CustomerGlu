//
//  SwiftUIView.swift
//  
//
//  Created by Himanshu Trehan on 24/07/21.
//

import SwiftUI
import UIKit
@available(iOS 13.0, *)
public struct CustomerWeb: View {
    
    @State var token:String
    @State var my_url=""
    var dismissModal: (() -> Void)?
    public init(cus_token:String,dismissModal: (() -> Void)?){
        print("web")
        token = cus_token
        self.dismissModal = dismissModal
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
                CustomerWebView(dismiss: {
                    dismissModal
                },my_url: my_url)
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
