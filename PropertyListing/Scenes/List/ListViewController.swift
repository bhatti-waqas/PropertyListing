//
//  ListViewController.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit
import Combine

final class ListViewController: UIViewController {
    private var viewModel: PropertiesListViewModel
    private var rootView: ListView
    private lazy var dataSource = makeDataSource()
    private var cancellables: [AnyCancellable] = []
    
    init(with viewModel: PropertiesListViewModel, rootView: ListView) {
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
        configureUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.load()
    }
    
    private func configureUI() {
        rootView.backgroundColor = .white
        rootView.spinner.startAnimating()
        rootView.tableView.dataSource = dataSource
        rootView.tableView.delegate = self
    }
    
    private func bindViewModel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        viewModel.stateDidUpdate.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: PropertiesListViewModelState) {
        switch state {
        case .failure(let errorMessage):
            rootView.spinner.isHidden = true
            presentAlert(errorMessage)
        case .success(let properties):
            self.showList(with: properties)
        }
    }
    
    private func showList(with properties: [PropertyRowViewModel]) {
        rootView.spinner.isHidden = true
        rootView.tableView.tableFooterView?.isHidden = true
        self.update(with: properties)
    }
}

//MARK: TableView Delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row ==  dataSource.snapshot().numberOfItems(inSection: .properties) - 1 {
            //load more
            guard viewModel.hasMore() else {
                tableView.tableFooterView?.isHidden = true
                return
            }
            tableView.tableFooterView?.isHidden = false
            viewModel.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellDidSelect(at: indexPath)
    }
}

//MARK: Diffacble Datasource
fileprivate extension ListViewController {
    enum Section: CaseIterable {
        case properties
    }
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, PropertyRowViewModel> {
        return UITableViewDiffableDataSource(
            tableView: rootView.tableView,
            cellProvider: {  tableView, indexPath, carRowViewModel in
                let cell: ListCell = self.rootView.tableView.dequeue(for: indexPath)
                cell.configure(with: carRowViewModel)
                return cell
            })
    }
    
    private func update(with cars: [PropertyRowViewModel], animate: Bool = false) {
        Run.onMainThread {
            var snapshot = NSDiffableDataSourceSnapshot<Section, PropertyRowViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(cars, toSection: .properties)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}
