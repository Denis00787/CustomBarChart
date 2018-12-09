//
//  BasicBarChart.swift
//  CustomChartBar
//
//  Created by Bordea Denis on 10/10/2018.
//  Copyright © 2018 Bordea Denis. All rights reserved.
//

import UIKit

public class CustomBarChart: UIView {
  
  /// the width of each bar
  let barWidth: CGFloat = 45.0
  
  /// space between each bar
  let space: CGFloat = 20.0
  
  /// space at the bottom of the bar to show the title
  private let bottomSpace: CGFloat = 15.0
  
  /// space at the top of each bar to show the value
  private let topSpace: CGFloat = 0.0
  
  /// contain all layers of the chart
  private let mainLayer: CALayer = CALayer()
  
  /// contain mainLayer to support scrolling
  private let scrollView: UIScrollView = UIScrollView()
  
 public var dataEntries: [BarEntry]? = nil {
    didSet {
      mainLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
      
      if let dataEntries = dataEntries {
        scrollView.contentSize = CGSize(width: (barWidth + space)*CGFloat(dataEntries.count), height: self.frame.size.height)
        mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        
        drawHorizontalLines()
        
        for i in 0..<dataEntries.count {
          showEntry(index: i, entry: dataEntries[i], color: dataEntries[i].color)
        }
      }
    }
  }
  
 public override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
 public convenience init() {
    self.init(frame: CGRect.zero)
    setupView()
  }
  
 public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  private func setupView() {
    scrollView.layer.addSublayer(mainLayer)
    self.addSubview(scrollView)
  }
  
 public override func layoutSubviews() {
    scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
  }
  
  private func showEntry(index: Int, entry: BarEntry, color: UIColor) {
    /// Starting x postion of the bar
    let xPos: CGFloat = space + CGFloat(index) * (barWidth + space)
    
    /// Starting y postion of the bar
    let yPos: CGFloat = translateHeightValueToYPosition(value: entry.firstHeight)
    let yPos1:CGFloat = translateHeightValueToYPosition(value: entry.secondHeight)
    let difference: CGFloat = yPos - yPos1
    
    
    
    
    if(difference < 0){
      drawBar(xPos: xPos, yPos: yPos,yPos1: yPos1, color: color, dif: difference)
      drawTopBuble(xPos: xPos+barWidth/2-10, yPos: yPos1, color: color)
      drawLeftTopBuble(xPos: xPos-40, yPos: yPos, color: UIColor.gray)
      
      /// Draw text above the bar
      drawTextValue(xPos: xPos+barWidth/2-107, yPos: yPos + 15, textValue: entry.firstTextValue, color: entry.color)//left text area
      drawTextValue(xPos: xPos+barWidth/2-60, yPos: yPos1 + 15,textValue: entry.secondTextValue, color: entry.color) //right text area
    }
    else
    {
      drawBar(xPos: xPos, yPos: yPos1,yPos1: yPos, color: color, dif: difference)
      drawTopBuble(xPos: xPos+barWidth/2-10, yPos: yPos1, color: color)
      drawLeftTopBuble(xPos: xPos-40, yPos: yPos, color: UIColor.gray)
      
      /// Draw text above the bar
      drawTextValue(xPos: xPos+barWidth/2-107, yPos: yPos + 15, textValue: entry.firstTextValue, color: entry.color)//left text area
      drawTextValue(xPos: xPos+barWidth/2-60, yPos: yPos1 + 15,textValue: entry.secondTextValue, color: entry.color) //right text area
    }
  }
  
  private func drawBar(xPos: CGFloat, yPos: CGFloat,yPos1:CGFloat, color: UIColor, dif: CGFloat) {
    let barLayer = CALayer()
    barLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth, height: mainLayer.frame.height - bottomSpace - yPos)
    barLayer.backgroundColor = UIColor(red: 251/255, green: 250/255, blue: 249/255, alpha: 1.0).cgColor
    let barLayer1 = CALayer()
    barLayer1.frame = CGRect(origin: CGPoint(x: xPos, y: yPos+21), size: CGSize(width: barWidth, height: abs(dif)))
    barLayer1.backgroundColor = color.cgColor
    barLayer1.opacity = 0.5
    mainLayer.addSublayer(barLayer)
    mainLayer.addSublayer(barLayer1)
  }
  
  private func drawHorizontalLines() {
    self.layer.sublayers?.forEach({
      if $0 is CAShapeLayer {
        $0.removeFromSuperlayer()
      }
    })
    let horizontalLineInfos = [["value": Float(0.0), "dashed": false], ["value": Float(0.5), "dashed": true], ["value": Float(1.0), "dashed": false]]
    for lineInfo in horizontalLineInfos {
      let xPos = CGFloat(0.0)
      let yPos = translateHeightValueToYPosition(value: (lineInfo["value"] as! Float))
      let path = UIBezierPath()
      path.move(to: CGPoint(x: xPos, y: yPos))
      path.addLine(to: CGPoint(x: scrollView.frame.size.width, y: yPos))
      let lineLayer = CAShapeLayer()
      lineLayer.path = path.cgPath
      lineLayer.lineWidth = 0.5
      if lineInfo["dashed"] as! Bool {
        lineLayer.lineDashPattern = [4, 4]
      }
      lineLayer.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
      self.layer.insertSublayer(lineLayer, at: 0)
    }
  }
  
  private func drawTextValue(xPos: CGFloat, yPos: CGFloat, textValue: String, color: UIColor) {
    let textLayer = CATextLayer()
    textLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth+120, height: 22)
    textLayer.foregroundColor = UIColor.white.cgColor
    textLayer.backgroundColor = UIColor.clear.cgColor
    textLayer.alignmentMode = CATextLayerAlignmentMode.center
    textLayer.contentsScale = UIScreen.main.scale
    textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
    textLayer.fontSize = 9
    textLayer.string = textValue
    mainLayer.addSublayer(textLayer)
  }
  
  private func drawTopBuble(xPos: CGFloat, yPos: CGFloat, color: UIColor) {
    let squarePath = UIBezierPath() // 1
    
    squarePath.move(to: CGPoint(x: xPos + 15, y: yPos + 14)) // top
    // 3 & 4
    squarePath.addLine(to: CGPoint(x: xPos + 60, y: yPos + 14)) //bottom
    squarePath.addLine(to: CGPoint(x: xPos + 60, y: yPos + 21)) //right
    squarePath.addLine(to: CGPoint(x: xPos + 8.75, y: yPos + 21)) //left
    
    let squarePath2 = UIBezierPath()
    
    squarePath2.move(to: CGPoint(x: xPos + 60, y: yPos + 21)) // top
    // 3 & 4
    squarePath2.addLine(to: CGPoint(x: xPos + 8.75, y: yPos + 21)) //left
    squarePath2.addLine(to: CGPoint(x: xPos + 15, y: yPos + 28)) //right
    squarePath2.addLine(to: CGPoint(x: xPos + 60, y: yPos + 28)) //bottom
    squarePath2.close()
    
    squarePath.close() // 5
    let segment4Layer = CAShapeLayer()
    segment4Layer.path = squarePath.cgPath
    segment4Layer.fillColor = color.cgColor
    segment4Layer.strokeColor = color.cgColor
    segment4Layer.lineWidth = 0.0
    
    let segment4Layer2 = CAShapeLayer()
    segment4Layer2.path = squarePath2.cgPath
    segment4Layer2.fillColor = color.cgColor
    segment4Layer2.strokeColor = color.cgColor
    segment4Layer2.lineWidth = 0.0
    mainLayer.addSublayer(segment4Layer)
    mainLayer.addSublayer(segment4Layer2)
  }
  
  private func drawLeftTopBuble(xPos: CGFloat, yPos: CGFloat, color: UIColor) {
    let squarePath = UIBezierPath() // 1
    squarePath.move(to: CGPoint(x: xPos + 8.75, y: yPos + 14)) // top
    // 3 & 4
    squarePath.addLine(to: CGPoint(x: xPos + 53, y: yPos + 14)) //bottom
    squarePath.addLine(to: CGPoint(x: xPos + 60, y: yPos + 21)) //right
    squarePath.addLine(to: CGPoint(x: xPos + 8.75, y: yPos + 21)) //left
    squarePath.close() // 5
    
    let squarePath2 = UIBezierPath()
    squarePath2.move(to: CGPoint(x: xPos + 8.75, y: yPos + 21)) // top
    // 3 & 4
    squarePath2.addLine(to: CGPoint(x: xPos + 60, y: yPos + 21)) //bottom
    squarePath2.addLine(to: CGPoint(x: xPos + 53, y: yPos + 28)) //right
    squarePath2.addLine(to: CGPoint(x: xPos + 8.75, y: yPos + 28)) //left
    squarePath2.close()
    
    let segment4Layer = CAShapeLayer()
    segment4Layer.path = squarePath.cgPath
    segment4Layer.fillColor = color.cgColor
    segment4Layer.strokeColor = color.cgColor
    segment4Layer.lineWidth = 0.0
    
    let segment4Layer2 = CAShapeLayer()
    segment4Layer2.path = squarePath2.cgPath
    segment4Layer2.fillColor = color.cgColor
    segment4Layer2.strokeColor = color.cgColor
    segment4Layer2.lineWidth = 0.0
    mainLayer.addSublayer(segment4Layer)
    mainLayer.addSublayer(segment4Layer2)
  }
  private func drawTitle(xPos: CGFloat, yPos: CGFloat, title: String, color: UIColor) {
    let textLayer = CATextLayer()
    textLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth + space, height: 22)
    textLayer.foregroundColor = color.cgColor
    textLayer.backgroundColor = UIColor.clear.cgColor
    textLayer.alignmentMode = CATextLayerAlignmentMode.center
    textLayer.contentsScale = UIScreen.main.scale
    textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
    textLayer.fontSize = 14
    textLayer.string = title
    mainLayer.addSublayer(textLayer)
  }
  
  private func translateHeightValueToYPosition(value: Float) -> CGFloat {
    let height: CGFloat = CGFloat(value) * (mainLayer.frame.height - bottomSpace - topSpace)
    return mainLayer.frame.height - bottomSpace - height
  }
}

