//
//  ListView.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 10/18/21.
//

import UIKit
import SnapKit

final class ListView: UIView {
    let topView: UIView = {
        let view = UIView()
        return view
    }()
    
    public let topLabel: UILabel = {
        let label = UILabel()
        label.text = StringKey.Generic.PropertiesTitle.get()
        label.font = CustomFontType.regular.getFont(.h1)
        return label
    }()
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = true
        return tableView
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
        [topView,tableView, spinner].forEach(addSubview)
        topView.addSubview(topLabel)
        tableView.register(cell: ListCell.self)
    }
    
    private func setupConstraints() {
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        topLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
