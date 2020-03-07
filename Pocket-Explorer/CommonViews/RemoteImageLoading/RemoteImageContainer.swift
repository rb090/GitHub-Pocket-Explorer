//
//  RemoteImageContainer.swift
//  Pocket-Explorer
//
//  Created by Roxana Bucura on 23.11.19.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct RemoteImageContainer: View {
    @ObservedObject var remoteImageContainerViewModel: RemoteImageContainerViewModel
    
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    init(imageUrl: URL?, width: CGFloat = 50, height: CGFloat = 50) {
        imageWidth = width
        imageHeight = height
        remoteImageContainerViewModel = RemoteImageContainerViewModel(imageUrl: imageUrl)
    }
    
    var body: some View {
        Image(uiImage: remoteImageContainerViewModel.imageData.isEmpty ? UIImage(imageLiteralResourceName: "img_loading") : UIImage(data: remoteImageContainerViewModel.imageData)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageWidth, height: imageHeight)
    }
}
