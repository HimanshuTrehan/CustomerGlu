//
//  SwiftUIView.swift
//  
//
//  Created by Himanshu Trehan on 27/07/21.
//

import SwiftUI

@available(iOS 13.0, *)
struct RewardWeb: View {
    @State var url:String
    var body: some View {
        if url == nil
        {
            EmptyView()
        }
        else{
        CustomerWebView(my_url: url)
        }
    }
}


