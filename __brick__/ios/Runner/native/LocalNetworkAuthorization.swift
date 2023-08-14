//
//  LocalNetworkAuthorization.swift
//  Runner
//
//  Created by zkteco on 2023/1/11.
//

import Foundation
import Network
 
@available(iOS 14.0, *)
class LocalNetworkAuthorization{
    static func checkLanAccess(_ completed: Optional<(Bool) -> Void> = .none) {
        DispatchQueue.global(qos: .userInitiated).async {
            let hostName = ProcessInfo.processInfo.hostName
            let isGranted = hostName.contains(".local")
            if let completed {
                DispatchQueue.main.async {
                    completed(isGranted)
                }
            }
        }
    }
}
