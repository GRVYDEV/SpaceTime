//
//  SpaceView.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/16/22.
//

import SwiftUI

struct SpaceView: View {
    @State var showControls = false
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded{
                toggleControls()
            }
    }
    var body: some View {
        ZStack {
            LocalVideo()
            if self.showControls {
                VStack{
                    SpaceControls()
                    Spacer()
                }
            }
        }
        .contentShape(Rectangle())
        .gesture(self.tap)
    }
    
    func toggleControls() {
        // TODO: Setup timer to hide after 3 seconds
        self.showControls = !self.showControls
    }
}

struct SpaceView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceView()
    }
}
