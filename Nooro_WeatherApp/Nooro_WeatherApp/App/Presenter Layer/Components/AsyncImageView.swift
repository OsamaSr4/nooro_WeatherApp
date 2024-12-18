//
//  AsyncImageView.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String
    let placeholder: Image
    let errorImage: Image
    let frameSize: CGSize
    
    var fullURL: URL? {
        if url.hasPrefix("//") {
            return URL(string: "https:\(url)")
        } else {
            return URL(string: url)
        }
    }
    
    var body: some View {
        AsyncImage(url: fullURL) { phase in
            switch phase {
            case .empty:
                placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(width: frameSize.width, height: frameSize.height)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: frameSize.width, height: frameSize.height)
            case .failure:
                errorImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: frameSize.width, height: frameSize.height)
            @unknown default:
                EmptyView()
            }
        }
    }
}
