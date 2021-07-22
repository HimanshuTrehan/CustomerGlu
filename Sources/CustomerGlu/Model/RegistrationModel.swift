//
//  File.swift
//  
//
//  Created by Himanshu Trehan on 22/07/21.
//

import Foundation

public  struct RegistrationModel:Codable {
   public var success:Bool?
   public var data: Data?
}
public  struct Data:Codable {
    public var token:String?
    
}
