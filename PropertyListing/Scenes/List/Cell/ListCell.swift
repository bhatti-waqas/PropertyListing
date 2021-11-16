//
//  ListCell.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit
import SnapKit

final class ListCell: UITableViewCell {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColor.grey.color
        label.font = CustomFontType.regular.getFont(.h4)
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFontType.regular.getFont(.h4)
        label.textColor = CustomColor.grey.color
        return label
    }()
    
    lazy var propertyImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(addressLabel)
        contentView.addSubview(propertyImageView)
        
        propertyImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(64)
            make.height.equalTo(64)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalTo(propertyImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: PropertyRowViewModel) {
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        guard let imageUrl = URL(string: viewModel.image) else { return }
        propertyImageView.setImage(with: imageUrl)
    }
}
