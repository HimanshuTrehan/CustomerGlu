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
        NavigationView
        {
            
            Text("Campaigns")
                .bold()
                .font(.system(size: 30))
                .navigationBarHidden(true)

            List(campaigns,id:\.campaignId)
                  {
                      element in
                      
                      if element.banner != nil
                      {
                      if element.banner?.imageUrl == nil && element.banner?.title == nil
                              {
                          BannerCell(image_url: "https://images.unsplash.com/photo-1614680376739-414d95ff43df?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGdhbWVzJTIwYmFubmVyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", title: "",url:element.url )
                               }
                          
                         else if element.banner?.imageUrl == nil{
                          BannerCell(image_url: "https://images.unsplash.com/photo-1614680376739-414d95ff43df?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGdhbWVzJTIwYmFubmVyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", title: (element.banner?.title)!,url: element.url)
                          }
                          
                          else if element.banner?.title == nil
                          {
                              BannerCell(image_url: (element.banner?.imageUrl!)!, title:"",url: element.url)
                          }
                          else{
                              BannerCell(image_url: (element.banner?.imageUrl!)!, title:(element.banner?.title!)!,url: element.url)
                              
                              
                              
                         
                          }

                      }
                      else
                      {
              BannerCell(image_url: "https://images.unsplash.com/photo-1614680376739-414d95ff43df?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGdhbWVzJTIwYmFubmVyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", title: "",url: element.url)
                          
                       
                          
                       
                      }
                      
                  }.onAppear(perform: {getCampaign()})
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
               //   .navigationViewStyle(StackNavigationViewStyle())
        }

      
       
    }
    }



