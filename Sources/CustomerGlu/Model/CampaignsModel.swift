//
//  File.swift
//  
//
//  Created by Himanshu Trehan on 23/07/21.
//

import Foundation


public struct CampaignsModel:Codable
{
    public var success:Bool?
    public var defaultUrl:String?
    public var campaigns:[Campaigns]?
}

public struct Campaigns:Codable
{
    public var campaignId:String?
    public var url:String?
    public var type:String?
    public var status:String?
    
}
