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
        VStack
        {
            Text("Rewards")
                .bold()
                .foregroundColor(.black)
                .font(.system(size: 40))
        if url == nil
        {
            EmptyView()
        }
        else{
        CustomerWebView(my_url: url)
        }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


