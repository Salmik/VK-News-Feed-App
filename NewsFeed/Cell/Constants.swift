//
//  Constants.swift
//  VKNewsFeed
//
//  Created by Zhanibek Lukpanov on 26.10.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 8, left: 8, bottom: 12, right: 8)
    static let topViewHeight = 36
    static let postLabelInsets = UIEdgeInsets(top: CGFloat(8 + Constants.topViewHeight + 8), left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    
    static let bottomViewViewHeight = 44
    static let bottomViewViewWidth = 80
    
    static let bottomIconSize: CGFloat = 24
    
    static let minifiedPostLimitsLines: CGFloat = 9
    static let minifiedPostLines: CGFloat = 7
    
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButoonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
}
