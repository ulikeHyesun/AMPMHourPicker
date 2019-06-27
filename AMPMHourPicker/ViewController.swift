//
//  ViewController.swift
//  CustomTimePicker
//
//  Created by 최혜선 on 26/06/2019.
//  Copyright © 2019 ulike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var timePicker: AMPMHourPicker! {
        didSet {
            timePicker.vc = self
        }
    }
    @IBOutlet fileprivate weak var timeLabel: UILabel!
    
    private var currentTime: String = "" {
        didSet {
            timeLabel.text = "선택한 시간은 \(currentTime)시 입니다"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: AMPMHourPickerDelegate {
    func AMPMHourPickerDidSelectedTime(time: String) {
        currentTime = time
    }
}
