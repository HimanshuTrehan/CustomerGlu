//
//  SwiftUIView.swift
//  
//
//  Created by Himanshu Trehan on 27/07/21.
//


import SwiftUI



@available(iOS 13.0, *)



struct BannerCell:View
{
    var image:String
    var title:String
    var body: some View
    {
        VStack(alignment: .center) {
         
            Image(systemName: "clock")
                .resizable()
                .frame(width: .infinity, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top,10)
            
            Text(title).font(.system(size: 25)).padding(.bottom,10)
     
                
                
            }.padding([.trailing,.bottom],10)

      
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.white)
        .modifier(CardModifier())
        .padding(.all, 10)

    }
        
    
        
    }

@available(iOS 13.0, *)
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 0)
            
            
    }
}
