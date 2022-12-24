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
        static let iconUrl = "https://tradernet.ru/logos/get-logo-by-ticker?ticker="
    }
    
    private lazy var iconTicketView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = false
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()

    private lazy var ticketLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19.0)
        label.text = "----"
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
        label.text = "--.-- %"
        label.font = UIFont.systemFont(ofSize: 19.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var lastTradeAndNameLabel: UILabel = {
        let label = UILabel()
        label.text = "__ | ___"
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.textColor = .gray
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "--.-- ( --.-- )"
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconTicketView.image = nil
    }
    
    func setupCell(model: TicketModel) {
        ticketLabel.text = model.ticket
    
        if model.priceChangePercent ?? 0.0 > 0.0 {
            percentLabel.text = "+" + String(format: "%.2f", model.priceChangePercent ?? 0.0) + "%"
            percentLabel.textColor = .systemGreen
        } else if model.priceChangePercent ?? 0.0 == 0.0 {
            percentLabel.text = String(format: "%.2f", model.priceChangePercent ?? 0.0) + "%"
            percentLabel.textColor = .systemGreen
        } else {
            percentLabel.text = String(format: "%.2f", model.priceChangePercent ?? 0.0) + "%"
            percentLabel.textColor = .systemRed
        }
        lastTradeAndNameLabel.text = String(format: Constants.tradeAndNameString, (model.lastTrade ?? ""), (model.name ?? ""))
        let minStep = model.minStepPrice
        var formatString = "%.2f"
        if let pointIndex = minStep.formatted().firstIndex(where: { $0 == "."}) {
            let minStepLeght = minStep.formatted().distance(from: pointIndex, to: minStep.formatted().endIndex) - 1
            formatString = "%.\(minStepLeght)f"
        }
        
        var priceChangePoint = "--.--"
        if let priceChangePointValue = model.priceChangePoint {
            let priceChangePointValueRounded = (priceChangePointValue/minStep).rounded()*minStep
            priceChangePoint = String(format: formatString, priceChangePointValueRounded)
            if priceChangePointValue > 0.0 {
                priceChangePoint = "+" + priceChangePoint
            }
        }
        
        var lastTradePrice = "--.--"
        if let lastTradePriceValue = model.lastTradePrice {
            let lastTradePriceValueRounded = (lastTradePriceValue/minStep).rounded()*minStep
            lastTradePrice = String(format: formatString, lastTradePriceValueRounded)
        }
        
        priceLabel.text = String(format: Constants.priceString, lastTradePrice /* String(format: "%.2f", model.lastTradePrice ?? 0.0)*/, priceChangePoint)
        
        if let isPositiveChange = model.isPositiveChange {
            percentLabel.textColor = .white
            backPercentView.backgroundColor = isPositiveChange ? .systemGreen : .systemRed
        } else {
            backPercentView.backgroundColor = .clear
        }
        
        if iconTicketView.image == nil {
            guard let ticketName = model.ticket else { return }
            iconTicketView.downloadIcon(with: Constants.iconUrl + ticketName.lowercased()) { [weak self] isSuccess in
                self?.iconTicketView.isHidden = !isSuccess
                if isSuccess {
                    self?.updateImageConstraints(isShow: isSuccess)
                }
            }
        }
    }
}

// MARK: - Private methods
extension TicketTableViewCell {
    private func initializeCell() {
        selectionStyle = .none
        
        [iconTicketView, ticketLabel, backPercentView, percentLabel, lastTradeAndNameLabel, priceLabel].forEach { view in
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
            make.leading.equalTo(contentView).offset(8.0)
            make.bottom.equalTo(contentView).offset(-6.0)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(6.0)
            make.trailing.equalTo(percentLabel)
            make.bottom.equalTo(lastTradeAndNameLabel)
        }
    }
    
    private func updateImageConstraints(isShow: Bool) {
        if isShow {
            iconTicketView.snp.makeConstraints { make in
                make.top.leading.equalTo(contentView).offset(8.0)
                make.size.equalTo(CGSize(width: 20.0, height: 20.0))
            }
            
            ticketLabel.snp.removeConstraints()
            
            ticketLabel.snp.updateConstraints { make in
                make.leading.equalTo(iconTicketView.snp.trailing).offset(4.0)
                make.centerY.equalTo(iconTicketView.snp.centerY)
            }
        }
    }
}
