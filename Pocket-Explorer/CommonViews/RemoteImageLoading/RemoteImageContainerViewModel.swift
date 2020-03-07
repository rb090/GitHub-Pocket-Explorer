//
//  RemoteImageFromUrl.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation
import Combine

class RemoteImageContainerViewModel: ObservableObject {
    
    @Published var imageData = Data()
    
    init(imageUrl: URL?) {
        guard let imgUrl = imageUrl else { return }
        
        URLSession.shared.dataTask(with: imgUrl) { (data, response, error) in
            guard let dataValue = data else { return }
            
            DispatchQueue.main.async {
                self.imageData = dataValue
            }
        }.resume()
    }
}
