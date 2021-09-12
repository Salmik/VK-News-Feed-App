//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Zhanibek Lukpanov on 16.10.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    func set(imageURL: String?) {
        
        guard let imageUrl = imageURL,  let url = URL(string: imageUrl) else {
            self.image = nil
            return
        }
        
        if let cacheResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cacheResponse.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleDownloadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleDownloadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cacherResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cacherResponse, for: URLRequest(url: responseURL))
    }
}
