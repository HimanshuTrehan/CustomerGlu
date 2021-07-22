//
//  File.swift
//  
//
//  Created by Himanshu Trehan on 22/07/21.
//

import Foundation

struct RegistrationModel:Codable {
    var success:Bool?
    var data: Data?
}
struct Data:Codable {
    var token:String?
    
}
