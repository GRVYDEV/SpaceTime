//
//  SpaceJoinView.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/17/22.
//

import SwiftUI
import MuxSpaces

struct SpaceJoinView: View {
    @EnvironmentObject private var space: SpaceClient
    var body: some View {
        if space.joined {
            SpaceView()
        } else {
            Text("Loading...")
        }
    }
}

struct SpaceJoinView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceJoinView()
    }
}
