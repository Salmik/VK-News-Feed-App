//
//  CellProtocols.swift
//  VKNewsFeed
//
//  Created by Zhanibek Lukpanov on 26.10.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get set }
    var date: String { get set }
    var text: String? { get set }
    var likes: String? { get set }
    var comments: String? { get set }
    var shares: String? { get set }
    var views: String? { get set }
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentPhoto: CGRect { get }
    var bottomView: CGRect { get }
    var totalHeight: CGFloat { get }
    var modeTextButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String { get }
    var width: Int { get }
    var height: Int { get }
}
