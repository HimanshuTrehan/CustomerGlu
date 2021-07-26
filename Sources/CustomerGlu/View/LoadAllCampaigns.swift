//
//  SwiftUIView.swift
//  
//
//  Created by Himanshu Trehan on 26/07/21.
//

import SwiftUI

@available(iOS 13.0, *)
public struct LoadAllCampaigns: View {
    var customer_token:String
    
    public init(customer_token:String)
    {
        self.customer_token = customer_token
    }
    var campaigns = CampaignsModel().campaigns
    
    public func getCampaign() {
        CustomerGlu().retrieveData(customer_token: customer_token, completion: { CampaignsModel in
            
       })
    }
   public var body: some View {
    ScrollView
    {
    List(campaigns!, id: \.id) { movie in
            Text(movie.campaignId)
        }
    }.onAppear(perform: {getCampaign()})
   }
  
}


