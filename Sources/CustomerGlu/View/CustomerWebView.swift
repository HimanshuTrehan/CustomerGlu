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
    
   @State var url:URL?
    var token:String
    public init(customer_token:String)
    {
        token = customer_token
     //   loadCampaigns(cus_token: token)
    }
    
    public func loadCampaigns(cus_token:String)
    {
        CustomerGlu().retrieveData(customer_token: cus_token) { CampaignsModel in
            url = URL(string: CampaignsModel.defaultUrl!)
            print(url as Any)
        }
    }
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
            print(message.body)
            let date = Date()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.messageToWebview(msg: "hello, I got your messsage: \(message.body) at \(date)")
            }
        }
        
        func messageToWebview(msg: String) {
            self.webView?.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(msg)')")
        }
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
         let myurl = URL(string: "https://amplify-launcher.dgdcnmnewfrib.amplifyapp.com/wallet/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJ0ZXN0dXNlcjIwMDIiLCJnbHVJZCI6IjM3YTlhMDBmLTA1NGEtNGVlZi05NjAyLTY5NTg5MmU3ZWRlZSIsImNsaWVudCI6IjBjNWZlYWM4LTVlMWMtNDljNS05ZDZkLWJlMmY1N2E5NzA3NCIsImRldmljZUlkIjoiZGV2aWNlYiIsImRldmljZVR5cGUiOiJhbmRyb2lkIiwiaWF0IjoxNjI3MDIwNDcwLCJleHAiOjE2NTg1NTY0NzB9.CefxPg0NhZ6dqyCmd8JatjDGoNLhuZZmAXVprrCFRRk")
    let request = URLRequest(url: myurl!)
        
        uiView.load(request)
        
    }
}

@available(iOS 13.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerWebView(customer_token: "s")
    }
}
