//
//  SwiftUIView.swift
//  
//
//  Created by Himanshu Trehan on 24/07/21.
//

import SwiftUI

@available(iOS 13.0, *)
public struct CustomerWeb: View {
    @State var token:String
    public init(cus_token:String){
        print("web")
        token = cus_token
    }
    
   public var body: some View {
        VStack
        {
        CustomerWebView()
        }.onAppear(perform: getCampaigns)
   }
    
    public func getCampaigns()
     {
        CustomerGlu().retrieveData(customer_token: token) { CampaignsModel in
            let my_url = CampaignsModel.defaultUrl
            print(my_url)
        }
     }
}