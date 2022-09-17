//
//  EnvironmentVariables.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/17/22.
//

import Foundation

enum EnvironmentVariableError: Error {
    case missingKeyID
    case missingPrivateKey
}

func fetchKeyId() throws -> String {
    guard let keyID = ProcessInfo.processInfo.environment["KEY_ID"] else {
        throw EnvironmentVariableError.missingKeyID
    }
    
    return keyID
}

func fetchPrivateKey() throws -> String {
    guard let privateKey = ProcessInfo.processInfo.environment["PRIVATE_KEY"] else {
        throw EnvironmentVariableError.missingPrivateKey
    }
    
    return privateKey
}
