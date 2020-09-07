//
//  NewsModel.swift
//  JSONImageLoad
//
//  Created by Ipung Dev Center on 07/09/20.
//  Copyright © 2020 Banyu Center. All rights reserved.
//

import Foundation
import Combine
import SwiftyJSON

class NewsModel : ObservableObject {
    
    @Published var data = [News]()
    
    init() {
        
        // any search query....
        //spaces must be replaced by +...
        
        let url = "http://newsapi.org/v2/top-headlines?country=id&category=science&apiKey=31403e958efb44f19100634eb4c502ea"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            let items = json["articles"].array!
            
            for i in items{

                let title = i["title"].stringValue
                
                let description = i["description"].stringValue
                
                let imurl = i["urlToImage"].stringValue
                
                DispatchQueue.main.async {
                    
                    self.data.append(News(title: title, image: imurl, description: description))
                }
            }
            
        }.resume()
    }
}
