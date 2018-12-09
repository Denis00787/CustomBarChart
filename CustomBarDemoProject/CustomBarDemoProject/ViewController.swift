//
//  ViewController.swift
//  CustomBarDemoProject
//
//  Created by Bordea Denis on 08/12/2018.
//  Copyright © 2018 Bordea Denis. All rights reserved.
//

import UIKit
import CustomBarChart

class ViewController: UIViewController {


  @IBOutlet weak var test: CustomBarChart!
  @IBOutlet weak var test2: CustomBarChart!
  @IBOutlet weak var test3: CustomBarChart!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var dataEntries1 :[BarEntry] = []
    var dataEntries2 :[BarEntry] = []
    var dataEntries3 :[BarEntry] = []

    let value1 = 500 % 1300
    let playerHeight: Float = Float(value1) / 1300
    
    let value2 = Int(1000) % 1300
    let usersHeight: Float = Float(value2) / 1300
    dataEntries1.append(BarEntry(color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), firstHeight: usersHeight, secondHeight:playerHeight, firstTextValue: "900 PTS", secondTextValue: "500 PTS", title: "Awesome chart"))
    dataEntries2.append(BarEntry(color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), firstHeight: usersHeight, secondHeight:playerHeight, firstTextValue: "900 PTS", secondTextValue: "500 PTS", title: "Awesome chart"))
    dataEntries3.append(BarEntry(color: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), firstHeight: usersHeight, secondHeight:playerHeight, firstTextValue: "900 PTS", secondTextValue: "500 PTS", title: "Awesome chart"))
    test.dataEntries = dataEntries1
    test2.dataEntries = dataEntries2
    test3.dataEntries = dataEntries3
  }


}

