//
//  MainListConfigurator.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 22.12.2022.
//

import Foundation
import UIKit

// MARK: - MainListConfiguratorProtocol
class MainListConfigurator: MainListConfiguratorProtocol {
    func configure() -> UIViewController {
        
        let interactor = MainListInteractor()
        
        let presenter = MainListPresenter()
        
        let router = MainListRouter()
        
        let view = MainListViewController()
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
