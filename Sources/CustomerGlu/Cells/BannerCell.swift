//
//  SwiftUIView.swift
//  
//
//  Created by Himanshu Trehan on 27/07/21.
//


import SwiftUI
import Combine
import Foundation
import UIKit
@available(iOS 13.0, *)

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Foundation.Data, Never>()
    var data = Foundation.Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}




@available(iOS 13.0, *)
struct BannerCell:View
{
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    var title:String
    var url:String
    
    
    init(image_url:String,title:String,url:String) {
        self.title = title
        self.url = url
        imageLoader = ImageLoader(urlString:image_url)
        
    }
    var body: some View
    {
        VStack(alignment: .center) {
                
          
//            Image(systemName: "clock")
//                .resizable()
//                .frame(width: .infinity, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .padding(.top,10)
            
            NavigationLink(destination: RewardWeb(url: url)) {
                Image(uiImage: image)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                    .frame(width:350, height:100)
                               .onReceive(imageLoader.didChange) { data in
                               self.image = UIImage(data: data) ?? UIImage()
                       }

            }
            Text(title).font(.system(size: 25)).padding(.bottom,10)

           
     

                
        }.padding(.all,10)

      
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
