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
    @State var campaigns:[Campaigns]=[]
    
    public func getCampaign() {
        CustomerGlu().retrieveData(customer_token: customer_token, completion: { CampaignsModel in
            campaigns = CampaignsModel.campaigns!
       })
    }
    


    public var body: some View
    {
        List(campaigns,id:\.campaignId)
        {
            element in
            if element.banner?.imageUrl == nil{
                BannerCell(image_url: "", title: (element.banner?.title)!)
            }
            else{
            BannerCell(image_url: (element.banner?.imageUrl!)!, title:(element.banner?.title!)!)
            }
           }.onAppear(perform: {getCampaign()})
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    }



