//
//  RealtimeQuotes.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 23.12.2022.
//

import Foundation

struct Quote: Codable {
    let c: String?
    let pcp: Double?
    let ltr: String?
    let name: String?
    let ltp: Double?
    let chg: Double?
    let min_step: Double?
    
    init(dictionary: [String: Any]) {
        self.c = dictionary["c"] as? String
        self.pcp = dictionary["pcp"] as? Double
        self.ltr = dictionary["ltr"] as? String
        self.name = dictionary["name"] as? String
        self.ltp = dictionary["ltp"] as? Double
        self.chg = dictionary["chg"] as? Double
        self.min_step = dictionary["min_step"] as? Double
    }
}
