//
//  SpaceItem.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/16/22.
//

import SwiftUI

struct SpaceItem: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CGFloat(8))
                .fill(Color.black.gradient)
                .padding()
            VStack {
                ZStack{
                    Circle()
                        .fill(Color.gray.gradient)
                    Text("S")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(Color.white)
                        .scaledToFit()
                }
                .frame(width: 50)
                Text("Space Name")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .scaledToFit()
                
            }
        }
        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
        .shadow(radius: 8)
        
    }
}

struct SpaceItem_Previews: PreviewProvider {
    static var previews: some View {
        SpaceItem()
    }
}
