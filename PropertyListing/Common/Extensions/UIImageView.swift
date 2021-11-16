//
//  UIImageView.swift
//  ListingChallenge
//
//  Created by Waqas Naseem on 11/9/21.
//

import UIKit
import SDWebImage

@objc extension UIImageView {
  @objc func setImage(with url: URL?) {
    backgroundColor = .black
    if let imageURL = url {
      sd_setImage(with: imageURL,
                  placeholderImage: MobileAsset.PlaceHolder.getImage(),
                  options: [.scaleDownLargeImages], completed: nil)
    } else {
        image =  MobileAsset.PlaceHolder.getImage()
    }
    layer.cornerRadius = 8.0
    layer.masksToBounds = true
  }
}
