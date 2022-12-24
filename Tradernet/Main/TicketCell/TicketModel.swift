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
    var minStepPrice: Double
    var isPositiveChange: Bool?
    
    init(from data: Quote) {
        self.ticket = data.c
        self.priceChangePercent = data.pcp
        self.lastTrade = data.ltr
        self.name = data.name
        self.lastTradePrice = data.ltp
        self.priceChangePoint = data.chg
        self.minStepPrice = data.min_step ?? 0.01
    }
    
    func isNeedUpdate() -> Bool {
        priceChangePercent != nil || lastTrade != nil || lastTrade != nil || priceChangePoint != nil
    }
    
    mutating func updateIfNeeded(with model: TicketModel) {
        if let priceChangePercent = model.priceChangePercent {
            self.isPositiveChange = priceChangePercent > self.priceChangePercent ?? 0.0
            self.priceChangePercent = priceChangePercent
        }
        if let lastTrade = model.lastTrade {
            self.lastTrade = lastTrade
        }
        if let lastTradePrice = model.lastTradePrice {
            self.lastTradePrice = lastTradePrice
        }
        if let priceChangePoint = model.priceChangePoint {
            self.priceChangePoint = priceChangePoint
        }
    }
}
