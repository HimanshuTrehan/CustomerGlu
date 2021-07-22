//
//  File.swift
//  
//
//  Created by Himanshu Trehan on 22/07/21.
//

//
//  TaskViewModel.swift
//  FirstProject
//
//  Created by Himanshu Trehan on 17/07/21.
//

import Foundation
import SwiftUI
@available(iOS 13.0, *)
public class CustomerGluRegistration:ObservableObject
{
     var model = [RegistrationModel]()
    @Published var apidata=RegistrationModel()
    var baseurl = "https://api.customerglu.com/user/v1/user/sdk?token=true"
    
    func doRegister(body:Any,completion:@escaping (RegistrationModel)->Void) ->RegistrationModel
    {

        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

         let myurl = URL(string: baseurl)
        var request = URLRequest(url: myurl!)
        request.httpMethod="POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error == nil && data != nil
            {
                do {
                    let dictonary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    as?[String:Any]
                    print(dictonary as Any)
                    do{
                        let mydata = try JSONDecoder().decode(RegistrationModel.self, from: data!)
                        print("data")
                        DispatchQueue.main.async{
                            self.apidata = mydata
                            completion(self.apidata)
                        }
                        
                    }
                    catch
                    {
                        print("json parsing error:\(error)")
                    }

                } catch  {
                    print("error: \(error)")
                }
            }
         
            
        }.resume()
        
        return self.apidata
    }
  
}
