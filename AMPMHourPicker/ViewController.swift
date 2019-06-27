//
//  ViewController.swift
//  AMPMHourPicker
//
//  Created by 최혜선 on 26/06/2019.
//  Copyright © 2019 ulike. All rights reserved.
//

import UIKit

public var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "HH:mm"
    return df
}()

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var timePicker: AMPMHourPicker! {
        didSet {
            timePicker.vc = self
        }
    }
    @IBOutlet fileprivate weak var timeTextView: UITextView!
    
    private var currentTime: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: AMPMHourPickerDelegate {
    func AMPMHourPickerDidSelectedTime(timeString: String, date: Date) {
        currentTime = timeString
        
        timeTextView.text = "선택한 시간은 \(currentTime)시 입니다 \n24시간 \(dateFormatter.string(from: date))"
    }
}
