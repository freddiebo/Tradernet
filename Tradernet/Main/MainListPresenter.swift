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
    
    var listOfTickets: [TicketModel] = []
    
    init() {
    }
}

// MARK: - Private Methods
extension MainListPresenter {
}

// MARK: - MainListViewToPresenterProtocol
extension MainListPresenter: MainListViewToPresenterProtocol {
    func viewLoaded() {
        interactor.connectSocket()
    }
}

// MARK: - MainListInteractorToPresenterProtocol
extension MainListPresenter: MainListInteractorToPresenterProtocol {
    func didReciveTicket(with model: TicketModel) {
        if let ticketIndex = listOfTickets.firstIndex(where: { $0.ticket == model.ticket }) {
//            listOfTickets[ticketIndex] = model
        } else {
            listOfTickets.append(model)
            view?.reloadData()
        }
        
        if listOfTickets.count == 32 {
            interactor.disconnectSocket()
        }
    }
}

