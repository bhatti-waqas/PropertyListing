//
//  PropertyDetailsViewController.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/14/21.
//

import Foundation
import UIKit
import Combine

final class PropertyDetailsViewController: UIViewController {
    private var viewModel: PropertyDetailViewModel
    private var rootView: PropertyDetailsView
    private var cancellables: [AnyCancellable] = []
    
    init(with viewModel: PropertyDetailViewModel, rootView: PropertyDetailsView) {
        self.viewModel = viewModel
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }
    
    private func bindViewModel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        viewModel.stateDidUpdate.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func configureUI() {
//        rootView.backgroundColor = .white
        rootView.spinner.startAnimating()
    }
    
    private func render(_ state: PropertiesDetailViewModelState) {
        switch state {
        case .failure(let errorMessage):
            rootView.spinner.isHidden = true
            presentAlert(errorMessage)
        case .success:
            updateUI()
        }
    }
    
    private func updateUI() {
        rootView.spinner.isHidden = true
        rootView.addressHeadingLabel.text = viewModel.getPropertyAddress()
        rootView.nameLabel.text = viewModel.getPropertyName()
        rootView.addressLabel.text = viewModel.getPropertyAddress()
        let url = URL(string: viewModel.getPropertyImageUrl())
        rootView.propertyImageView.setImage(with: url)
    }
}
