//
//  BarEntry.swift
//  CustomBarChart
//
//  Created by Bordea Denis on 09/12/2018.
//  Copyright © 2018 Bordea Denis. All rights reserved.
//

import Foundation
import UIKit

public struct BarEntry {
  let color: UIColor
  
  /// Ranged from 0.0 to 1.0
  let firstHeight: Float
  
  let secondHeight : Float
  
  /// To be shown on top of the bar
  let firstTextValue: String
  
  let secondTextValue : String
  
  /// To be shown at the bottom of the bar
  let title: String
  
  public init()
  {
    self.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    self.firstHeight = 0
    self.secondHeight = 0
    self.firstTextValue = ""
    self.secondTextValue = ""
    self.title = ""
  }
  
  public init(color: UIColor, firstHeight: Float, secondHeight: Float, firstTextValue: String, secondTextValue: String, title: String )
  {
    self.color = color
    self.firstHeight = firstHeight
    self.secondHeight = secondHeight
    self.firstTextValue = firstTextValue
    self.secondTextValue = secondTextValue
    self.title = title
  }
}
