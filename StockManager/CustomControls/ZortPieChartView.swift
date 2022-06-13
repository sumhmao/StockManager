//
//  ZortPieChartView.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 14/6/2565 BE.
//

import UIKit

struct ZortPieChartSegment {
    let title: String
    var value: Double
    var color: UIColor = .clear

    fileprivate mutating func updateData(value: Double, color: UIColor) {
        self.value = value
        self.color = color
    }
}

final class ZortPieChartView: UIView {

    private(set) var segments = [ZortPieChartSegment]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUIComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUIComponents()
    }

    private func initUIComponents() {
        backgroundColor = .clear
        isOpaque = false
    }

    func setSegments(_ segments: [ZortPieChartSegment]) {
        var newSegments = [ZortPieChartSegment]()
        let valueCount = segments.reduce(0, {$0 + $1.value})
        let sortedSegments = segments.sorted { s1, s2 in
            return s1.value > s2.value
        }
        var index = 0
        for var segment in sortedSegments {
            let colorIndex = index % ZortPieChartColorSet.colors.count
            let color = ZortPieChartColorSet.colors[colorIndex]
            segment.updateData(value: segment.value / valueCount, color: color)
            newSegments.append(segment)
            index += 1
        }
        self.segments = newSegments
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        let radius = min(frame.size.width, frame.size.height) * 0.5
        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        var startAngle = -CGFloat.pi * 0.5

        for segment in segments {
            ctx?.setFillColor(segment.color.cgColor)
            let endAngle = startAngle + 2 * .pi * segment.value
            ctx?.move(to: viewCenter)
            ctx?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            ctx?.fillPath()
            startAngle = endAngle
        }

        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.close()

        path.addArc(withCenter: viewCenter, radius: radius * 0.65, startAngle: 0.0,
                    endAngle: .pi * 2.0, clockwise: true)

        let mask = CAShapeLayer()
        mask.fillRule = .evenOdd
        mask.path = path.cgPath
        layer.mask = mask
    }

}
