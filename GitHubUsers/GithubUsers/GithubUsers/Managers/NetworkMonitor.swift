//
//  NetworkMonitor.swift
//  GithubUsers
//
//  Created by Nino on 3/20/22.
//

import Foundation
import Network

protocol NetworkConnectivityDelegate{
    func connectivityDidChange(isConnected:Bool)
}

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global(qos: .background)
    private let monitor:NWPathMonitor
    
    private var isConnected: Bool = false
    
    var delegate:NetworkConnectivityDelegate? {
        didSet{
            delegate?.connectivityDidChange(isConnected: isConnected)
        }
    }
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self] path in
            
            self?.isConnected = path.status != .unsatisfied
            
            self?.delegate?.connectivityDidChange(isConnected: self?.isConnected ?? false)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
            
    }
}
