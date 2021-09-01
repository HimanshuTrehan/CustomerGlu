import Foundation
import SwiftUI
import UIKit
@available(iOS 13.0, *)

extension UIViewController{ static func topViewController() -> UIViewController? {

      let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

      if var topController = keyWindow?.rootViewController {
          while let presentedViewController = topController.presentedViewController {
              topController = presentedViewController
          }

          return topController
      }

      return nil
  }
}
@available(iOS 13.0, *)

public class CustomerGlu:ObservableObject {
    
    @available(iOS 13.0, *)
    public init(){
    }
    var text = "Hello World !"
   @Published var apidata = RegistrationModel()
    @Published var campaigndata = CampaignsModel()
    var register_url = "https://api.customerglu.com/user/v1/user/sdk?token=true"
    var load_campaigns_url = "https://api.customerglu.com/reward/v1.1/user"
   var send_events = "https://stream.customerglu.com/v3/server"
    
    public func doRegister(body:[String:AnyHashable],completion:@escaping (RegistrationModel)->Void)
      {
        var userdata = body
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            print(uuid)
            userdata["deviceId"] = uuid
        }
          let jsonData = try! JSONSerialization.data(withJSONObject: userdata, options: .fragmentsAllowed)

           let myurl = URL(string: register_url)
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
                            let token = self.apidata.data?.token
                            UserDefaults.standard.set(token, forKey: "CustomerGlu_Token")
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
          
      }
    public func retrieveData(customer_token:String,completion:@escaping (CampaignsModel)->Void)
    {
    
        let token = "Bearer "+customer_token
         let myurl = URL(string: load_campaigns_url)
        var request = URLRequest(url: myurl!)
        request.httpMethod="GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")



        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error == nil && data != nil
            {
           //     do {
//                    let dictonary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                    as?[String:Any]
//                    print(dictonary as Any)
                    do{
                        let mydata = try JSONDecoder().decode(CampaignsModel.self, from: data!)
                        print("data")
                        DispatchQueue.main.async{
                          self.campaigndata = mydata
                            completion(self.campaigndata)
                            print(self.campaigndata)
                        }

                    }
                    catch
                    {
                        print("json parsing error:\(error)")
                    }

             //   } catch  {
                 //   print("error: \(error)")
             //   }
            }
         
            
        }.resume()
        
    }
    public func openUiKitWallet() {

        let swiftUIView = OpenUiKitWallet()
    //UIHostingController
//        UINavigationController(rootViewController: UIViewController)
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.modalPresentationStyle = .fullScreen
    
//       self.navigationController?.pushViewController(hostingController, animated: true)
        
        guard let topController = UIViewController.topViewController() else {
                          return
                      }
               topController.present(hostingController, animated: true, completion: nil)
    }
    
    public func loadAllCampaignsUiKit() {

        let swiftUIView = LoadCampaignsUiKit()
    //UIHostingController
//        UINavigationController(rootViewController: UIViewController)
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.modalPresentationStyle = .fullScreen
    
//       self.navigationController?.pushViewController(hostingController, animated: true)
        guard let topController = UIViewController.topViewController() else {
                   return
               }
        topController.present(hostingController, animated: true, completion: nil)

    }
    
    public func getReferralId(deepLink:URL) -> String
    {
        let queryItems = URLComponents(url: deepLink, resolvingAgainstBaseURL: true)?.queryItems
        let referrerUserId = queryItems?.filter({(item) in item.name == "userId"}).first?.value
        
        return referrerUserId ?? ""
    }
    
    public  func displayNotification(remoteMessage:[String:AnyHashable]) {
        
        let myalert = remoteMessage["alert"] as? [String:AnyHashable]
            let nudge_url = myalert?["nudge_url"]
            print(nudge_url as Any)
            if ((myalert?["glu_message_type"]  as? String) == "in-app") {
                let inapp_type = myalert?["inapp"] as! [String : AnyHashable]
                let notification_type = inapp_type["type"]
                if notification_type as! String == "bottom-slider"{
                    let swiftUIView = NotificationHandler(my_url: nudge_url as! String)
         
                    let hostingController = UIHostingController(rootView: swiftUIView)
              //      hostingController.modalPresentationStyle = .fullScreen
                    guard let topController = UIViewController.topViewController() else {
                                      return
                                  }
                           topController.present(hostingController, animated: true, completion: nil)                }
                else   if notification_type as! String == "bottom-default"{
                    let swiftUIView = NotificationHandler(my_url: nudge_url as! String)
         
                    let hostingController = UIHostingController(rootView: swiftUIView)
               //     hostingController.modalPresentationStyle = .overFullScreen
                    hostingController.isModalInPresentation = true

                    guard let topController = UIViewController.topViewController() else {
                                      return
                                  }
                           topController.present(hostingController, animated: true, completion: nil)                }
                else  if notification_type as! String == "middle-default"{
                    let swiftUIView = NotificationHandler(my_url: nudge_url as! String, ismiddle:true)
         
                    let hostingController = UIHostingController(rootView: swiftUIView)
                    hostingController.modalPresentationStyle = .overCurrentContext
                   hostingController.view.backgroundColor = .clear
                 //   hostingController.modalPresentationStyle = .fullScreen
                 //   UIApplication.keyWin?.rootViewController?.present(hostingController, animated: true, completion: nil)
                    guard let topController = UIViewController.topViewController() else {
                                      return
                                  }
                           topController.present(hostingController, animated: true, completion: nil)
                }
                else
                {
                let swiftUIView = NotificationHandler(my_url: nudge_url as! String)
     
                let hostingController = UIHostingController(rootView: swiftUIView)
                hostingController.modalPresentationStyle = .fullScreen
                    guard let topController = UIViewController.topViewController() else {
                                      return
                                  }
                           topController.present(hostingController, animated: true, completion: nil)            }
            }
            else
            {
                return
            }
        
    

    }
    public  func notificationFromCustomerGlu(remoteMessage:[String:AnyHashable])-> Bool {
        let myalert = remoteMessage["alert"] as? [String:AnyHashable]
        let Type = myalert?["type"]
        if Type as! String == "CustomerGlu"
        {
            if ((myalert?["glu_message_type"]  as? String) == "in-app")  {
                return true
            }
            else
            {
                return false
            }
        }
        
        else{
            return false
        }
        
    }

    
    public func sendEvents(writeKey:String,eventName:String,user_id:String,eventProperties:[String:Any])
      {
        let date = Date()
        let event_id = UUID().uuidString
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let timestamp = dateformatter.string(from: date)
        let evp = String(describing: eventProperties)
        print(evp)
        let eventData = [
            "event_id": event_id,
            "event_name": eventName,
            "user_id": user_id,
            "timestamp": timestamp,
            "event_properties":evp
        ]
          let jsonData = try! JSONSerialization.data(withJSONObject: eventData, options: .fragmentsAllowed)
            print(jsonData)
           let myurl = URL(string: send_events)
          var request = URLRequest(url: myurl!)
          request.httpMethod="POST"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(writeKey, forHTTPHeaderField: "x-api-key")

        //  request.httpBody = eventData

          URLSession.shared.dataTask(with: request) { data, response, error in

              if error == nil && data != nil
              {
                  do {
                      let dictonary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                      as?[String:Any]
                      print(dictonary as Any)


                  } catch  {
                      print("error: \(error)")
                  }
              }


          }.resume()
          
      }
}
