//
//  SpacesVideo.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/17/22.
//

import SwiftUI
import UIKit
import MuxSpaces

struct SpacesVideo: UIViewRepresentable {
    
    let space: Space
    let track: VideoTrack
    let view = UIView()
    
    init(
        space: Space,
        track: VideoTrack
    ) {
        self.track = track
        self.space = space
        space.addVideoView(into: self.view, for: track)
    }
    
    func makeUIView(context: Context) -> UIView {
        self.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
