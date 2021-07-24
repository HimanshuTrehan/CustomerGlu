//
//  SwiftUIView.swift
//  
//
//  Created by Himanshu Trehan on 23/07/21.
//

import SwiftUI
import WebKit
@available(iOS 13.0, *)

public struct CustomerWebView: UIViewRepresentable {
    
    @State var my_url:String
    var token=""

 
   public class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var webView: WKWebView?
    public override init(){}
       public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.webView = webView
        }
        
        // receive message from wkwebview
      public  func userContentController(
            _ userContentController: WKUserContentController,
            didReceive message: WKScriptMessage
        ) {
        print("Body message",message.body)
                    
        
        if message.name == "callback" {

            guard let bodyString = message.body as? String,
                  let bodyData = bodyString.data(using: .utf8) else { fatalError() }

            let bodyStruct = try? JSONDecoder().decode(EventModel.self, from: bodyData)
            if bodyStruct?.eventName == "CLOSE"
            {
                
            }
            
            if bodyStruct?.eventName == "OPEN_DEEPLINK" {
                
            }
            
            if bodyStruct?.eventName == "SHARE" {
                
            }
              
        }
        
     
          }
        
        
//        func messageToWebview(msg: String) {
//
//            self.webView?.evaluateJavaScript("MY message:\(msg)")
//
//        }
    }
    
  public  func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
   public  func makeUIView(context: Context) -> WKWebView  {
        let coordinator = makeCoordinator()
          let userContentController = WKUserContentController()
          userContentController.add(coordinator, name: "callback")
          
          let configuration = WKWebViewConfiguration()
          configuration.userContentController = userContentController
          
          let _wkwebview = WKWebView(frame: .zero, configuration: configuration)
          _wkwebview.navigationDelegate = coordinator
          
    return _wkwebview
   }
  public  func updateUIView(_ uiView: WKWebView, context: Context) {
    let test_url = URL(string: my_url)
   
    if(test_url != nil)
    {
    let request = URLRequest(url: test_url!)
        
        uiView.load(request)
    }
    
    
    }
}
