//
//  MainListViewController.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 22.12.2022.
//

import UIKit
import SnapKit

class MainListViewController: UIViewController {
    
    var presenter: MainListViewToPresenterProtocol?
  
    private lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorColor = .gray
//        table.rowHeight = 82
        table.register(TicketTableViewCell.self, forCellReuseIdentifier: "ticket")
        table.delegate = self
        table.dataSource = self
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .systemBackground
        presenter?.viewLoaded()
    }
}

// MARK: - UITableViewDelegate protocol
extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.listOfTickets.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter?.listOfTickets[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticket", for: indexPath) as! TicketTableViewCell
        print(model)
        cell.setupCell(model: model)
        return cell
    }
    
}

// MARK: - Private Methods
extension MainListViewController {
    private func configure() {
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view)
        }
    }
}

// MARK: - MainListViewProtocol
extension MainListViewController: MainListViewProtocol {
    func reloadData() {
        table.reloadData()
    }
}
