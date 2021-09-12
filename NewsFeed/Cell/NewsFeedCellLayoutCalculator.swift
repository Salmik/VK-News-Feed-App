//
//  NewsFeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Zhanibek Lukpanov on 20.10.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

protocol NewsFeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: [FeedCellPhotoAttachmentViewModel], isFullSizePost: Bool) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var bottomView: CGRect
    var totalHeight: CGFloat
    var postLabelFrame: CGRect
    var modeTextButtonFrame: CGRect
    var attachmentPhoto: CGRect
}

final class NewsFeedCellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }

    func sizes(postText: String?, photoAttachment: [FeedCellPhotoAttachmentViewModel], isFullSizePost: Bool) -> FeedCellSizes {
        
        var showModeTextButton = false
        
        // MARK:- Работа с postLabelFrame
        
        let cardVIewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardVIewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitsLines
            
            if !isFullSizePost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showModeTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK:- Работа с modeTextButtonFrame
        
        var modeTextButtonSize = CGSize.zero
        
        if showModeTextButton {
            modeTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOirgin = CGPoint(x: Constants.moreTextButoonInsets.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOirgin, size: modeTextButtonSize)
        
        // MARK:- Работа с attachment
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentsFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachment.first {
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            if photoAttachment.count == 1 {
                attachmentsFrame.size = CGSize(width: cardVIewWidth, height: cardVIewWidth * ratio)
            } else if photoAttachment.count > 1 {
                
               var photos = [CGSize]()
                for photo in photoAttachment {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                
                let rowHeight = RowLayout.rowHeightCounter(superViewWidth: cardVIewWidth, photosArray: photos)
                attachmentsFrame.size = CGSize(width: cardVIewWidth, height: rowHeight!)
            }
            
        }
        
        
        // MARK:- Работа с bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentsFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardVIewWidth, height: Constants.bottomViewHeight))
        
        // MARK:- Работа с totalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(bottomView: bottomViewFrame,
                     totalHeight: totalHeight,
                     postLabelFrame: postLabelFrame,
                     modeTextButtonFrame: moreTextButtonFrame,
                     attachmentPhoto: attachmentsFrame)
    }

}
