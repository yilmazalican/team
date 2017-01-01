//
//  CellView.swift
//  iFlat
//
//  Created by Eren AY on 26/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import JTAppleCalendar
// Calendar dayCell
class CellView: JTAppleDayCellView {
    // Outlet of day
    @IBOutlet var dayLabel: UILabel!
    // Outlet of highlight for selecting
    @IBOutlet var selectedView: UIView!
    var isSelected = false;
    
}
