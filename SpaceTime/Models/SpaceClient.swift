//
//  SpaceWrapper.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/17/22.
//

import Foundation
import MuxSpaces
import SwiftUI
import Combine


enum LocalVideoError: Error {
    case noVideo
    case noSpace
    case noLocalPart
}

class SpaceClient: ObservableObject {
    @Published var joined: Bool = false
    @Published var space: Space?
    // TODO: make this typed
    @Published var error: String?
    @Published var localParticipant: Participant?
    @Published var remoteParticipants: [Participant] = []
    
    var cancellables: Set<AnyCancellable> = []
    
    // TODO: Take space id and username
    init(mock: Bool = false) {
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
        if mock {
            let space = Space.NewMock(mockParticipants: 1)
            print(space)
            self.localParticipant = space.localParticipant
            self.remoteParticipants = space.remoteParticipants
            self.space = space
        } else {
            self.space = Space(token: token)
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    //TODO: Refactor this
    func setupHandlers() {
        guard let space = self.space else { return }
        
        space.eventPublishers
            .participantJoined
            .map(\.participant)
            .print("Participant Joined")
            .sink(receiveValue: { [weak self] participant in
                guard let self = self else { return }
                
                self.remoteParticipants = space.remoteParticipants
                
            })
            .store(in: &cancellables)
        
        space.eventPublishers
            .participantLeft
            .map(\.participant)
            .print("Participant Left")
            .sink(receiveValue: {[weak self] participant in
                guard let self = self else {return}
                
                self.remoteParticipants = space.remoteParticipants
                
            })
            .store(in: &cancellables)
        
        space.eventPublishers
            .videoTrackSubscriptions
            .print("Track Subscribed")
            .sink{[weak self] (subscribed: Space.Event.VideoTrackSubscribed) in
                guard let self = self else {return}
                
                self.remoteParticipants = space.remoteParticipants
            }
            .store(in: &cancellables)
        
        space.eventPublishers
            .videoTrackUnsubscriptions
            .print("Track Unsubscribed")
            .sink{[weak self] (trackUnsubscribed: Space.Event.VideoTrackUnsubscribed) in
                guard let self = self else {return}
                
                self.remoteParticipants = space.remoteParticipants
            }
            .store(in: &cancellables)
        
        space.eventPublishers
            .videoTrackPublications
            .filter {$0.participant.isLocal}
            .print("Local track pubbed")
            .sink { [weak self] (published: Space.Event.VideoTrackPublished) in
                guard let self = self else {return}
                
                self.localParticipant = space.localParticipant
            }
            .store(in: &cancellables)
        
        space.eventPublishers
            .videoTrackUnpublications
            .filter {$0.participant.isLocal}
            .print("Local track unpubbed")
            .sink { [weak self] (trackUnpublished: Space.Event.VideoTrackUnpublished) in
                guard let self = self else {return}
                
                self.localParticipant = space.localParticipant
            }
            .store(in: &cancellables)
        
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
                    self.remoteParticipants = space.remoteParticipants
                    self.setupHandlers()
                    self.publishAudio()
                    self.publishVideo()
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
        self.localParticipant = nil
        self.remoteParticipants = []
        cancellables.forEach { $0.cancel() }
        print("left space")
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
    
    func publishAudio() {
        guard let space = self.space else {
            print("no space")
            return
        }
        let options = AudioCaptureOptions()
        let micTrack = space.makeMicrophoneCaptureAudioTrack(options: options)
        space.publishTrack(micTrack){
            (error: AudioTrack.PublishError?) in
            guard error == nil else {
                print("Audio capture error: \(error)")
                return
                
            }
        }
    }
    
    func publishVideo() {
        guard let space = self.space else {
            print("no space")
            return
        }
        let options = CameraCaptureOptions()
        let camTrack = space.makeCameraCaptureVideoTrack(options: options)
        space.publishTrack(camTrack){
            (error: VideoTrack.PublishError?) in
            guard error == nil else {
                print("Video capture error: \(error)")
                return
            }
        }
    }
}
