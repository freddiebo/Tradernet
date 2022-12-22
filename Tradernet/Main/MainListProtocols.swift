//
//  MainListProtocols.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 22.12.2022.
//

import Foundation
import UIKit

protocol MainListConfiguratorProtocol: AnyObject {
    func configure() -> UIViewController
}

protocol MainListInteractorProtocol: AnyObject {
    func doSomething()
}

protocol MainListViewToPresenterProtocol: AnyObject {
    func viewLoaded()
}

protocol MainListInteractorToPresenterProtocol: AnyObject {
    func presentSomething()
}

protocol MainListRouterProtocol: AnyObject {
    func routeToSomewhere()
}

protocol MainListViewProtocol: AnyObject {
    func displaySomething()
}
