//
//  NetworkStatus.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import Foundation

enum NetworkStatus {
    case successful
    case failure(statusCode: Int?)
}
