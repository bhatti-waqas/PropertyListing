//
//  ListingViewController.swift
//  ListingChallenge
//
//  Created by Waqas Naseem on 11/9/21.
//

import Foundation
import UIKit

final class ListingViewController: UITableViewController {
    
    // MARK:- Private Properties
    private let viewModel: ListingViewModel
    private let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK:- Init
    init?(coder: NSCoder, viewModel: ListingViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        configureUI()
        viewModel.delegate = self
        viewModel.load()
    }
    
    private func configureUI() {
        self.title = viewModel.screenTitle
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        tableView.backgroundView = spinner
    }
    
    private func reload() {
        Run.onMainThread {
            self.spinner.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListingTableViewCell = tableView.dequeue(for: indexPath)
        let viewModel = viewModel.row(at: indexPath.row)
        cell.configure(with: viewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellDidSelect(at: indexPath)
    }
    
}
//MARK: ViewModel Delegates
extension ListingViewController: ListingViewModelDelegate {
    
    func onViewModelReady() {
        self.reload()
    }
    
    func onViewModelError(with error: Error) {
        presentAlert(error.localizedDescription)
    }
    
    func onViewModelNeedsUpdate(at indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
}
