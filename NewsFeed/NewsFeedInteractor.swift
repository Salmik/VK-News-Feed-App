//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Zhanibek Lukpanov on 15.10.2020.
//  Copyright (c) 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
    
  private var postIDS = [Int]()
  private var feedResponse: FeedResponse?
    
  private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }

    switch request {
    case .getNewsFeed:
        fetcher.getfeed {[weak self] (feedResponse) in
            self?.feedResponse = feedResponse
            self?.presentFeed()
        }
    case .revealPostId(postID: let postID):
        postIDS.append(postID)
        presentFeed()
        
    case .getUser:
        fetcher.getUser {[weak self] (userResponse) in
            self?.presenter?.presentData(response: .presentUserInfo(user: userResponse))
        }
    }
  }
  
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: .presentFeed(feed: feedResponse, revealesPostIds: postIDS))
    }
}
