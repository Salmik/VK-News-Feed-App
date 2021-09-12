//
//  NewsFeedModels.swift
//  VKNewsFeed
//
//  Created by Zhanibek Lukpanov on 15.10.2020.
//  Copyright (c) 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case revealPostId(postID: Int)
                case getUser
            }
        }
        struct Response {
            enum ResponseType {
                case presentFeed(feed: FeedResponse, revealesPostIds: [Int])
                case presentUserInfo(user: UserResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case showFeed(feedViewModel: FeedViewModel)
                case displayUser(userViewModel: UserViewModel)
            }
        }
        
    }
    
}

struct UserViewModel: TittleViewViewModel {
    var photoUrlsString: String?
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postID: Int
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String
        var width: Int
        var height: Int
    }
    
    let cells: [Cell]
    
    
}
