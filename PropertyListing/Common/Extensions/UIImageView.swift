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
                  placeholderImage: UIImage(named: "placeHolder"),
                  options: [.scaleDownLargeImages], completed: nil)
    } else {
      image = UIImage(named: "placeHolder")
    }
    layer.cornerRadius = 8.0
    layer.masksToBounds = true
  }
}
