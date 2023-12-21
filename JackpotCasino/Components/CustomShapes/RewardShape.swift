//
//  AwardShape.swift
//

import SwiftUI

struct RewardShape: Shape {
    func path(in rect: CGRect) -> Path {
     var path = Path()
        
        let hR = 0.52
        let wR = 0.25
        let radius: CGFloat = 10
        let bottomLeft = CGPoint(x: rect.minX + radius, y: rect.maxY)
        let middleLeft = CGPoint(x: rect.minX, y: rect.maxY - rect.height * hR)
        let leftCenter = CGPoint(x: rect.maxX * wR, y: rect.maxY - rect.height * hR - radius)
        let topLeft = CGPoint(x: rect.maxX * wR + radius, y: rect.minY + radius)
        let topRight = CGPoint(x: rect.maxX * (1 - wR) - 2*radius, y: rect.minY)
        let rightCenter = CGPoint(x: rect.maxX * (1 - wR) - radius , y: rect.maxY - rect.height*hR - 2 * radius)
        let middleRight = CGPoint(x: rect.maxX - radius , y: rect.maxY - rect.height*hR - radius)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY - radius)
        
        path.move(to: bottomLeft)
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: Angle(radians: .pi/2), endAngle: Angle(radians: .pi), clockwise: false)
        path.addLine(to: middleLeft)
        path.addArc(center: CGPoint(x: middleLeft.x + radius, y: middleLeft.y), radius: radius, startAngle: Angle(radians: .pi), endAngle: Angle(radians: 3 * .pi / 2), clockwise: false)
        path.addLine(to: leftCenter)
        path.addArc(center: CGPoint(x: leftCenter.x, y: leftCenter.y - radius), radius: radius, startAngle: Angle(radians:.pi/2), endAngle: Angle(radians: 0), clockwise: true)
        path.addLine(to: topLeft)
        path.addArc(center: CGPoint(x: topLeft.x + radius, y: topLeft.y), radius: radius, startAngle: Angle(radians:.pi), endAngle: Angle(radians: 3 * .pi / 2), clockwise: false)
        path.addLine(to: topRight)
        path.addArc(center: CGPoint(x: topRight.x, y: topRight.y + radius), radius: radius, startAngle: Angle(radians: -.pi/2), endAngle: Angle(radians: 0), clockwise: false)
        path.addLine(to: rightCenter)
        path.addArc(center: CGPoint(x: rightCenter.x + radius, y: rightCenter.y), radius: radius, startAngle: Angle(radians: .pi), endAngle: Angle(radians: .pi/2), clockwise: true)
        path.addLine(to: middleRight)
        path.addArc(center: CGPoint(x: middleRight.x, y: middleRight.y + radius), radius: radius, startAngle: Angle(radians: -.pi/2), endAngle: Angle(radians: 0), clockwise: false)
        path.addLine(to: bottomRight)
        path.addArc(center: CGPoint(x: bottomRight.x - radius, y: bottomRight.y), radius: radius, startAngle: Angle(radians: 0), endAngle: Angle(radians: .pi/2) , clockwise: false)
        path.closeSubpath()
        
        return path
    }
}
