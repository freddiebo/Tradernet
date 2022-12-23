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
    func connectSocket()
    
    func disconnectSocket()
}

protocol MainListViewToPresenterProtocol: AnyObject {
    var listOfTickets: [TicketModel] { get }
    
    func viewLoaded()
}

protocol MainListInteractorToPresenterProtocol: AnyObject {
    func didReciveTicket(with model: TicketModel)
}

protocol MainListRouterProtocol: AnyObject {
    func routeToSomewhere()
}

protocol MainListViewProtocol: AnyObject {
    func reloadData()
}
