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
    
   @State var my_url=URL(string: "")
    var token:String

    public init(customer_token:String)
    {
        token = customer_token
        print("ftoken",customer_token)
        print("vtoken",token)
        loadCampaigns(cus_token: token)
    }
    
    public func loadCampaigns(cus_token:String)
    {
        CustomerGlu().retrieveData(customer_token: cus_token) { CampaignsModel in
            my_url = URL(string: CampaignsModel.defaultUrl)
            print(my_url)
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
    var test_url = my_url
    let request = URLRequest(url: test_url)
        
        uiView.load(request)
    
    }
}

@available(iOS 13.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerWebView(customer_token: "s")
    }
}
