//
//  MainListInteractor.swift
//  Tradernet
//
//  Created by Vladislav Bondarev on 22.12.2022.
//

import Starscream

class MainListInteractor {
    
    private enum Constants {
        static let url = "wss://wss.tradernet.ru"
        static let listOfTicket = ["SP500.IDX", "AAPL.US", "RSTI", "GAZP", "MRKZ", "RUAL", "HYDR", "MRKS", "SBER", "FEES", "TGKA", "VTBR", "ANH.US", "VICL.US", "BURG.US", "NBL.US", "YETI.US", "WSFS.US", "NIO.US", "DXC.US", "MIC.US", "HSBC.US", "EXPN.EU", "GSK.EU", "SHP.EU", "MAN.EU", "DB1.EU", "MUV2.EU", "TATE.EU", "KGF.EU", "MGGT.EU", "SGGD.EU"]
    }
    
    weak var presenter: MainListInteractorToPresenterProtocol?

    private var socket: WebSocket?
    private var isConnected: Bool = false
//    private let server = WebSocketServer()
    
    init() {
        guard let url = URL(string: Constants.url) else { return }
        let request = URLRequest(url: url)
        socket = WebSocket(request: request)
        socket?.delegate = self
    }
}

// MARK: - Private Methods
extension MainListInteractor {
    private func writeData() {
        do {
            let data = try JSONSerialization.data(withJSONObject: ["quotes", Constants.listOfTicket])
            socket?.write(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func decodeRecive(text: String) {
        do {
            let jsonData = Data(text.utf8)
            let json: [Any] = try JSONSerialization.jsonObject(with: jsonData) as! [Any]

            if json[0] as? String == "q",
            let dist = json[1] as? [String: Any] {
                let model = Quote.init(dictionary: dist)
                presenter?.didReciveTicket(with: TicketModel(from: model))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - MainListInteractorProtocol
extension MainListInteractor: MainListInteractorProtocol {
    func connectSocket() {
        guard let socket = socket else { return }
        socket.connect()
    }
    
    func disconnectSocket() {
        socket?.disconnect()
    }
}

// MARK: - WebSocketDelegate
extension MainListInteractor: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
            writeData()
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            decodeRecive(text: string)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
}
