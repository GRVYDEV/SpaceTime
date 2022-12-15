//
//  SpaceView.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/16/22.
//

import SwiftUI

//TODO: fix UI bug between local video and controls
struct SpaceView: View {
    @EnvironmentObject private var space: SpaceClient
    @State var showControls = false
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded{
                toggleControls()
            }
    }
    
    var body: some View {
        ZStack {
            if let participant = space.remoteParticipants.filter{!$0.isLocal}.first {
                RemoteVideo(space: space.space!, participant: participant)
            }
            if let part = space.localParticipant {
                LocalVideo(space: space.space!, localParticipant: part, client: space)
            }
            if self.showControls {
                VStack{
                        SpaceControls(spaceClient: space)
                        Spacer()
                }
            }
        }
        .contentShape(Rectangle())
        .gesture(self.tap)
    }
    
    init() {
    }
    
    func toggleControls() {
        // TODO: Setup timer to hide after 3 seconds
        self.showControls = !self.showControls
    }
}

struct SpaceView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceView()
            .environmentObject(SpaceClient(mock:true))
            .background(
                Image("starfield-bg")
                    .ignoresSafeArea()
            )
    }
}
