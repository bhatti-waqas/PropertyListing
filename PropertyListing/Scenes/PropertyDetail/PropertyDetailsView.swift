//
//  PropertyDetailsView.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/14/21.
//

import Foundation
import UIKit
import SnapKit

final class PropertyDetailsView: UIView {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = CustomFontType.regular.getFont(.h3)
        return label
    }()
    
    lazy var addressHeadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = CustomFontType.regular.getFont(.h1)
        return label
    }()
    
    lazy var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = StringKey.Generic.AddressTitle.get()
        label.font = CustomFontType.regular.getFont(.h3)
        return label
    }()
    
    lazy var propertyImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    public let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setup() {
        backgroundColor = CustomColor.themeColor.color
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [addressHeadingLabel, nameLabel, addressTitleLabel,addressLabel, propertyImageView, spinner].forEach(addSubview)
    }
    
    private func setupConstraints() {
        addressHeadingLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(80)
        }
        
        propertyImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(addressHeadingLabel.snp.bottom).offset(20)
            make.height.equalTo(propertyImageView.snp.width).multipliedBy(0.57)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(propertyImageView.snp.bottom).offset(10)
        }
        
        addressTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalTo(addressTitleLabel.snp.trailing).offset(5)
            make.top.equalTo(addressTitleLabel)
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
