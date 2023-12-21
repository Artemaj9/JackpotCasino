//
//  TriangleShape.swift
//

import Foundation
import SwiftUI

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.maxY)
        let leftCorner = CGPoint(x: rect.minX, y: rect.minY)
        let rightCorner = CGPoint(x: rect.maxX, y: rect.minY)
        
        var path = Path()
        path.move(to: center)
        path.addLine(to: leftCorner)
        path.addLine(to: rightCorner)
        path.closeSubpath()
        
        return path
    }
}
