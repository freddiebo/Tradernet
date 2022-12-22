//
//  MainListInteractor.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 22.12.2022.
//

class MainListInteractor {
    weak var presenter: MainListInteractorToPresenterProtocol?

    init() {
        
    }
}

// MARK: - Private Methods
extension MainListInteractor {
}

// MARK: - MainListInteractorProtocol
extension MainListInteractor: MainListInteractorProtocol {
    func doSomething() {
        presenter?.presentSomething()
    }
}
