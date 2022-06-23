//
//  String + MD.swift
//  URLSessionStartProject
//
//  Created by a.kravcov on 23.06.2022.
//

import Foundation
import CryptoKit

extension String {
    
    func md5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
