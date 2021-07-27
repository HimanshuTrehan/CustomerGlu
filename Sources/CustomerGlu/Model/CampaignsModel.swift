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
    public var defaultUrl=""
    public var campaigns:[Campaigns]?
}

public struct Campaigns:Codable
{
    public var campaignId=""
    public var url:String=""
    public var type:String=""
    public var status:String=""
    public var banner:Banner?
    
}

public struct Banner:Codable
{
    public var title=""
    public var body=""
//    public var imageUrl=""
//    public var totalUsers=""
//    public var completedUsers=""
//    public var inProgressUsers=""
//    public var totalSteps=""
//    public var stepsCompleted=""
//    public var stepsRemaining=""

    
}
