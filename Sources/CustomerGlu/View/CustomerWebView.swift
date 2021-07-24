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

    public init(url:String)
    {
        print("webb")
        my_url = url
        print("myyyyyyy")
        print(my_url)
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
    let test_url = URL(string: my_url)
    print(test_url)
    let ourl = URL(string: "https://google.com")
    let request = URLRequest(url: ourl!)
        
        uiView.load(request)
    
    
    }
}
