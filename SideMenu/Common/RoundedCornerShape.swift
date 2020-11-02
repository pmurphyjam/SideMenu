//
//  RoundedCornerShape.swift
//  SideMenu
//
//  Created by Pat Murphy on 11/2/20.
//

import SwiftUI

struct RoundedCornerShape: Shape {
    let radius: CGFloat
    let orientation:Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        if(orientation)
        {
            //Right Side Corners
            let tl = CGPoint(x: rect.minX, y: rect.minY)
            let bl = CGPoint(x: rect.minX , y: rect.maxY)
            let brs = CGPoint(x: rect.maxX - radius, y: rect.maxY)
            let brc = CGPoint(x: rect.maxX - radius, y: rect.maxY - radius)
            let trs = CGPoint(x: rect.maxX, y: rect.minY + radius)
            let trc = CGPoint(x: rect.maxX - radius, y: rect.minY + radius)

            path.move(to: tl)
            path.addLine(to: bl)
            path.addLine(to: brs)
            path.addRelativeArc(center: brc, radius: radius,
            startAngle: Angle.degrees(-270), delta: Angle.degrees(-90))
            path.addLine(to: trs)
            path.addRelativeArc(center: trc, radius: radius,
            startAngle: Angle.degrees(0), delta: Angle.degrees(-90))
            path.addLine(to: tl)
        }
        else
        {
            //Left Side Corners
            let tr = CGPoint(x: rect.maxX, y: rect.minY)
            let br = CGPoint(x: rect.maxX, y: rect.maxY)
            let bls = CGPoint(x: rect.minX + radius, y: rect.maxY)
            let blc = CGPoint(x: rect.minX + radius, y: rect.maxY - radius)
            let tls = CGPoint(x: rect.minX, y: rect.minY + radius)
            let tlc = CGPoint(x: rect.minX + radius, y: rect.minY + radius)

            path.move(to: tr)
            path.addLine(to: br)
            path.addLine(to: bls)
            path.addRelativeArc(center: blc, radius: radius,
            startAngle: Angle.degrees(90), delta: Angle.degrees(90))
            path.addLine(to: tls)
            path.addRelativeArc(center: tlc, radius: radius,
            startAngle: Angle.degrees(90), delta: Angle.degrees(180))
            path.addLine(to: tr)
        }

        return path
    }
}
