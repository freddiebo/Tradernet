//
//  TicketTableViewCell.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 23.12.2022.
//

import UIKit
import SnapKit

final class TicketTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let tradeAndNameString = "%@ | %@"
        static let priceString = "%@ ( %@ )"
        static let greenColor = UIColor(red: 150.0, green: 190.0, blue: 90.0, alpha: 0.0)
        static let redColor = UIColor(red: 250.0, green: 70.0, blue: 90.0, alpha: 0.0)
    }

    private lazy var ticketLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19.0)
        label.text = "AAPL.US"
        label.textColor = .black
        return label
    }()
    
    private lazy var backPercentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "-0.98 %"
        label.font = UIFont.systemFont(ofSize: 19.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var lastTradeAndNameLabel: UILabel = {
        let label = UILabel()
        label.text = "FIX | Apple Inc."
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.textColor = .gray
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "175.83(-0.18)"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(model: TicketModel) {
        ticketLabel.text = model.ticket
        if model.priceChangePercent ?? 0.0 >= 0 {
            percentLabel.text = "+" + String(format: "%.2f", model.priceChangePercent ?? 0.0) + "%"
            percentLabel.textColor = .systemGreen
        } else {
            percentLabel.text = String(format: "%.2f", model.priceChangePercent ?? 0.0) + "%"
            percentLabel.textColor = .systemRed
        }
        lastTradeAndNameLabel.text = String(format: Constants.tradeAndNameString, (model.lastTrade ?? ""), (model.name ?? ""))
        priceLabel.text = String(format: Constants.priceString, String(format: "%.2f", model.lastTradePrice ?? 0.0), String(format: "%.2f", model.priceChangePoint ?? 0.0))
    }
}

// MARK: - Private methods
extension TicketTableViewCell {
    private func initializeCell() {
        selectionStyle = .none

        [ticketLabel, backPercentView, percentLabel, lastTradeAndNameLabel, priceLabel].forEach { view in
            contentView.addSubview(view)
        }
        
        ticketLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView).offset(8.0)
        }
        
        backPercentView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8.0)
            make.trailing.equalTo(contentView).offset(-8.0)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.center.equalTo(backPercentView)
            make.top.equalTo(backPercentView).offset(2.0)
            make.leading.equalTo(backPercentView).offset(4.0)
            make.trailing.equalTo(backPercentView).offset(-4.0)
            make.bottom.equalTo(backPercentView).offset(-2.0)
        }
        
        lastTradeAndNameLabel.snp.makeConstraints { make in
            make.top.equalTo(ticketLabel.snp.bottom).offset(6.0)
            make.leading.equalTo(ticketLabel)
            make.bottom.equalTo(contentView).offset(-6.0)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(6.0)
            make.trailing.equalTo(percentLabel)
            make.bottom.equalTo(lastTradeAndNameLabel)
        }
    }
}
