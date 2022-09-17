//
//  LocalVideo.swift
//  Spaced Out
//
//  Created by Garrett Graves on 9/15/22.
//

import SwiftUI

let boundX = UIScreen.main.bounds.width
let boundY = UIScreen.main.bounds.height
let localWidth = 100.0
let localHeight = 175.0

struct VideoPosition: Equatable {
    var x: VideoPos
    var y: VideoPos
    
    init(x: VideoPos, y: VideoPos) {
        self.x = x
        self.y = y
    }
    
    static let topLeft = VideoPosition(x: .left, y: .top)
    static let bottomLeft = VideoPosition(x: .left, y: .bottom)
    static let topRight = VideoPosition(x: .right, y: .top)
    static let bottomRight = VideoPosition(x: .right, y: .bottom)
    
    static func == (lhs: VideoPosition, rhs: VideoPosition) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

struct VideoPos: Equatable {
    var value: Double
    
    init(value: Double) {
        self.value = value
    }
    
    static let left =  VideoPos(value: 0 + (localWidth / 2) + 15.0)
    static let right =  VideoPos(value: boundX - (localWidth / 2) - 15.0)
    static let top =  VideoPos(value: 0 + localHeight / 2 + 5)
    static let bottom = VideoPos(value: boundY - localHeight - 5)
}

struct LocalVideo: View {
    @State var isDragging = false
    @State var offset: CGSize = CGSize.zero
    @State var color: Color = Color.blue
    @State var x: Double
    @State var y: Double
    @State var position: VideoPosition
    
    var drag: some Gesture {
        DragGesture()
            .onChanged{ gesture in
                self.isDragging = true
                self.offset = gesture.translation
                self.x = gesture.location.x
                self.y = gesture.location.y
            }
            .onEnded {_ in
                computePosition()
            }
    }
    var body: some View {
        RoundedRectangle(cornerRadius: CGFloat(8))
            .fill(self.color)
            .frame(width: localWidth, height: localHeight)
            .position(x: self.x, y: self.y)
            .gesture(drag)
            .animation(.spring(), value: x)
            .animation(.spring(), value: y)
            .shadow(radius: 8)
        
    }
    
    init(initialPos: VideoPosition = .bottomRight) {
        self.position = initialPos
        self.x = initialPos.x.value
        self.y = initialPos.y.value
    }
    
    func computePosition() {
        self.x += self.offset.width
        self.x += self.offset.height
        let offX = abs(self.offset.width)
        let offY = abs(self.offset.height)
        if offX > 100 && offY > 100 {
            switch self.position {
            case .topLeft:
                leftToRight()
                topToBottom()
            case .topRight:
                rightToLeft()
                topToBottom()
            case .bottomLeft:
                leftToRight()
                bottomToTop()
            case .bottomRight:
                rightToLeft()
                bottomToTop()
            default:
                print("thing")
            }
            resetToPos()
        }
        switch offX > offY {
        case true:
            switch self.position {
            case .topLeft:
                leftToRight()
            case .topRight:
                rightToLeft()
            case .bottomLeft:
                leftToRight()
            case .bottomRight:
                rightToLeft()
            default:
                print("thing")
            }
            resetToPos()
            
        case false:
            switch self.position {
            case .topLeft:
                topToBottom()
            case .topRight:
                topToBottom()
            case .bottomLeft:
                bottomToTop()
            case .bottomRight:
                bottomToTop()
            default:
                print("thing")
            }
            resetToPos()
        }
    }
    
    func resetToPos() {
        self.x = self.position.x.value
        self.y = self.position.y.value
    }
    
    func leftToRight() {
        guard self.offset.width > 100 else {
            resetToPos()
            return
        }
        self.position.x = .right
    }
    
    func rightToLeft() {
        guard self.offset.width < -100 else {
            resetToPos()
            return
        }
        self.position.x = .left
    }
    
    func topToBottom() {
        guard self.offset.height > 100 else {
            resetToPos()
            return
        }
        self.position.y = .bottom
    }
    
    func bottomToTop() {
        guard self.offset.height < -100 else {
            resetToPos()
            return
        }
        self.position.y = .top
    }
}

struct LocalVideo_Previews: PreviewProvider {
    static var previews: some View {
        LocalVideo().border(.red)
    }
}
