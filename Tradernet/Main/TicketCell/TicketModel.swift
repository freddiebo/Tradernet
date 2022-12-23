//
//  TicketModel.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 23.12.2022.
//

import Foundation

struct TicketModel {
    let ticket: String?
    var priceChangePercent: Double?
    var lastTrade: String?
    var name: String?
    var lastTradePrice: Double?
    var priceChangePoint: Double?
    
    init(from data: Quote) {
        self.ticket = data.c
        self.priceChangePercent = data.pcp
        self.lastTrade = data.ltr
        self.name = data.name
        self.lastTradePrice = data.ltp
        self.priceChangePoint = data.chg
    }
}
