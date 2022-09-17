//
//  TokenGenerator.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/17/22.
//

import Foundation
import SwiftJWT

enum TokenGenerationError: Error {
    case malformedPrivateKey
    case tokenSignatureFailure
}

let tokenDuration: Double = 43200

fileprivate struct SpaceClaims: Claims {
    var sub: String
    var exp: Date? = Date().addingTimeInterval(tokenDuration)
    var kid: String
    var aud: String = "rt"
    var role: String = "publisher"
    var participant_id: String
    
    func encode() throws -> String {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .secondsSince1970
        jsonEncoder.outputFormatting = [.sortedKeys]
        let data = try jsonEncoder.encode(self)
        return JWTEncoder.base64urlEncodedString(data: data)
    }
}

class TokenGenerator {
    static func generate(
        displayName: String,
        spaceID: String = "rI00iYfASAeqIUKsiDYkVUsVIjLAkcE00LYXpKGmB7MsM"
    ) throws -> String {
        let keyId = try fetchKeyId()
        let privateKey = try fetchPrivateKey()
        
        let participantID = "\(displayName)|\(UUID().uuidString)"
        
        let claims = SpaceClaims(
            sub: spaceID,
            kid: keyId,
            participant_id: participantID
        )
        
        var token = JWT(
            header: Header(
                typ: nil
            ),
            claims: claims
        )
        
        // TODO: Remove this or improve logic
        let pem = "-----BEGIN PRIVATE KEY-----" + privateKey + "-----END PRIVATE KEY-----"
        
        guard let base64EncodedSigningKey = pem.data(
            using: .utf8
        ) else {
            throw TokenGenerationError.malformedPrivateKey
        }
        
        let signer = JWTSigner.rs256(privateKey: base64EncodedSigningKey)
        
        do {
            let signedToken = try token.sign(using: signer)
            return signedToken
        } catch {
            throw TokenGenerationError.tokenSignatureFailure
        }
    }
}
