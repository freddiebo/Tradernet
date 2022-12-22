//
//  MainListPresenter.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 22.12.2022.
//

import UIKit

class MainListPresenter {
    weak var view: MainListViewProtocol?
    var interactor: MainListInteractorProtocol!
    var router: MainListRouterProtocol?
    
    init() {
    }
}

// MARK: - Private Methods
extension MainListPresenter {
}

// MARK: - MainListViewToPresenterProtocol
extension MainListPresenter: MainListViewToPresenterProtocol {
    func viewLoaded() {
        interactor.doSomething()
    }
}

// MARK: - MainListInteractorToPresenterProtocol
extension MainListPresenter: MainListInteractorToPresenterProtocol {
    func presentSomething() {
        view?.displaySomething()
    }
}

