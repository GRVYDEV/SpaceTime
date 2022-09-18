//
//  SpaceList.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/16/22.
//

import SwiftUI

struct SpaceListView: View {
    @EnvironmentObject private var space: SpaceClient
    @State var rows: [SpaceRow]
    var body: some View {
        NavigationView {
            ScrollView{
                Grid {
                    ForEach(rows) { row in
                        NavigationLink {
                            SpaceJoinView()
                                .navigationBarBackButtonHidden()
                                .onAppear{
                                    space.joinSpace()
                                }
                                .onDisappear {
                                    space.leave()
                                }
                                .background(
                                    Image("starfield-bg")
                                        .ignoresSafeArea()
                                )
                        } label: {
                            GridRow {
                                SpaceItem()
                                if row.right != nil {
                                    SpaceItem()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Spaces")
        }
    }
    
    init(spaces: Array<APISpace>) {
        var idx = 0
        var rows: [SpaceRow] = []
        // There gotta be a better way...
        while idx < spaces.count {
            if idx + 1 >= spaces.count {
                rows.append(SpaceRow(left: spaces[idx]))
                idx += 1
            } else {
                rows.append(SpaceRow(left: spaces[idx], right: spaces[idx+1]))
                idx += 2
            }
        }
        self.rows = rows
    }
}

struct SpaceListView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceListView(spaces: spaceList)
            .background(
                Image("starfield-bg")
            )
    }
}
