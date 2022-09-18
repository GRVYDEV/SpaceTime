//
//  SpaceControls.swift
//  SpaceTime
//
//  Created by Garrett Graves on 9/16/22.
//

import SwiftUI

let circleSize = CGFloat(55)

struct SpaceControls: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            VStack(alignment: .leading){
                HStack {
                    ZStack{
                        Circle()
                            .fill(Color.gray)
                            .frame(width: circleSize)
                        Text("S")
                        
                    }
                    VStack(alignment: .leading){
                        Text("Space Name")
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "video.fill")
                            Text("Mux Spaces")
                        }
                    }
                }
                .foregroundColor(Color.white)
                .padding(.bottom)
                HStack(spacing: 50) {
                    Button(action: {dismiss()}) {
                        ZStack {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: circleSize)
                            Image(systemName: "video")
                                .foregroundColor(Color.white)
                        }
                    }
                    Button(action: {dismiss()}) {
                        ZStack {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: circleSize)
                            Image(systemName: "mic")
                                .foregroundColor(Color.white)
                        }
                    }
                    Button(action: {dismiss()}) {
                        ZStack {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: circleSize)
                            Image(systemName: "rectangle.inset.filled.and.person.filled")
                                .foregroundColor(Color.white)
                        }
                    }
                    Button(action: {dismiss()}) {
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: circleSize)
                            Image(systemName: "xmark")
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width)
            .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.2), Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom))
    }
}

struct SpaceControls_Previews: PreviewProvider {
    static var previews: some View {
        SpaceControls()
            .background(
                Image("starfield-bg")
            )
    }
}
