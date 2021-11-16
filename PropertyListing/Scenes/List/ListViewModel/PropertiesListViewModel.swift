//
//  PropertiesListViewModel.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/13/21.
//

import Foundation
import Combine

final class PropertiesListViewModel {
    private let useCase: PropertiesUseCase
    private let navigator: ListingNavigator
    private var currentPage: Int = 1
    private let perPage: Int = 10
    private var listResponseModel: PropertyResponseModel? = nil
    private var listRowViewModels: [PropertyRowViewModel] = []
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    private let stateDidUpdateSubject = PassthroughSubject<PropertiesListViewModelState, Never>()
    private var cancellable: [AnyCancellable] = []
    
    init(useCase: PropertiesUseCase, navigator: ListingNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    //MARK:- Public methods
    public func load() {
        listRowViewModels.removeAll()
        self.useCase.fetchProperties(page: currentPage, perPage: perPage)
            .sink { resul in
                switch resul {
                case .success(let responseModel):
                    self.listResponseModel = responseModel
                    let rowViewModels = self.viewModels(from: responseModel.data)
                    self.listRowViewModels.append(contentsOf: rowViewModels)
                    self.stateDidUpdateSubject.send(.success(self.listRowViewModels))
                case .failure(let error):
                    self.stateDidUpdateSubject.send(.failure(error.localizedDescription))
                }
            }.store(in: &cancellable)
    }
    
    private func viewModels(from properties: [Property]) -> [PropertyRowViewModel] {
        return properties.map{
            .init(
                id: $0.id,
                name: $0.name ?? "",
                address: $0.address,
                image: $0.image ?? ""
            )
        }
    }
    
    private func getTotalPages() -> Int {
        guard let lastPage = listResponseModel?.meta.lastPage else { return 0 }
        return lastPage
    }
    
    func cellDidSelect(at indexPath: IndexPath) {
        guard let listRowViewModel = listRowViewModels[safe: indexPath.row] else { return }
        navigator.showDetails(with: listRowViewModel.id)
    }
    
    func numberOfRows() -> Int {
        return listRowViewModels.count
    }
    
    func hasMore() -> Bool {
        let page = currentPage + 1
        guard page <= getTotalPages() else { return false}
        return true
    }
    
    func loadMore() {
        guard hasMore() else { return }
        currentPage += 1
        load()
        return
    }
}
