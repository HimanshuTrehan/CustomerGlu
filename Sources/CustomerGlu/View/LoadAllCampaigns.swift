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
    @State var campaigns = CampaignsModel().campaigns
    
    public func getCampaign() {
        CustomerGlu().retrieveData(customer_token: customer_token, completion: { CampaignsModel in
            campaigns = CampaignsModel.campaigns
       })
    }
   public var body: some View {
    ScrollView
    {
        if campaigns == nil
        {
            EmptyView()
        }
        else
        {
    List(campaigns!, id: \.campaignId) { movie in
        Text(movie.url)
        }
    }
   }.onAppear(perform: {getCampaign()})
   }
  
}


