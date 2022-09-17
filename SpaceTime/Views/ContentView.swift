//
//  ContentView.swift
//  Spaced Out
//
//  Created by Garrett Graves on 9/15/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SpaceListView(spaces: spaceList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct HelloView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}
