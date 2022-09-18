//
//  RemoteVideo.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/17/22.
//

import SwiftUI
import MuxSpaces

struct RemoteVideo: View {
    @State var space: Space
    @State var participant: Participant
    
    let width = UIScreen.main.bounds.width - 15
    var height: Double {
        width * 0.5625
    }
    var body: some View {
        let _ = print(participant.id)
        if let track = participant.videoTracks.values.first {
            SpacesVideo(space: space, track: track)
                .cornerRadius(8)
                .frame(width: width, height: height)
                .shadow(radius: 8)
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue)
                .frame(width: width, height: height)
                .shadow(radius: 8)
        }
    }
}

//struct RemoteVideo_Previews: PreviewProvider {
//    static var previews: some View {
//        RemoteVideo()
//    }
//}
