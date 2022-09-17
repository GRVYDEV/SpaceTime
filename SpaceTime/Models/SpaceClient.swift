//
//  SpaceWrapper.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/17/22.
//

import Foundation
import MuxSpaces

class SpaceClient: ObservableObject {
    @Published var joined: Bool = false
    @Published var space: Space?
    // TODO: make this typed
    @Published var error: String?
    
    // TODO: Take space id and username
    init() {
        var token: String?
        do {
            token = try TokenGenerator.generate(displayName: "Garrett")
        } catch {
            token = nil
        }
        
        guard let token = token else {
            self.error = "Invalid Token"
            print("token error")
            return
        }
        // JOIN SPACE
        print(token)
        self.space = Space(token: token)
    }
    
    func joinSpace() {
        guard !self.joined else {
            print("space already joined")
            return
        }
        if let space = self.space {
            space.join{ (result:Result<Participant, Space.JoinError>) in
                switch result {
                case .success(_):
                    print("joined")
                    self.joined = true
                case .failure(let failure):
                    self.error = "Failed to join space: \(failure)"
                    if let err = self.error {
                        print(err)
                    }
                }
            }
        }
    }
    
    func leave() {
        guard let space = self.space else {
            print("no space")
            return
        }
        
        space.leave()
        self.joined = false
        print("left space")
    }
}
