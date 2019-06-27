//
//  ampmPicker.swift
//  CustomTimePicker
//
//  Created by 최혜선 on 26/06/2019.
//  Copyright © 2019 ulike. All rights reserved.
//

import UIKit

protocol AMPMHourPickerDelegate: class {
    func AMPMHourPickerDidSelectedTime(time: String)
}

class AMPMHourPicker: UIPickerView {
    
    private let ampm: [Int: String] = [0: "오전", 1: "오후"]
    fileprivate var hours: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    fileprivate var selectedAMPM: Int = 0
    fileprivate var selectedHour: Int = 0
    weak var vc: AMPMHourPickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        self.delegate = self
        self.dataSource = self
    }
}

extension AMPMHourPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? ampm.count : hours.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? ampm[row] : String(hours[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 선택한 component가 0이면 selectedAMPM 에 저장
        syncAMPMAndHourComponents()
        
        selectedAMPM = self.selectedRow(inComponent: 0)
        selectedHour = self.selectedRow(inComponent: 1)
        
        var selectedTimes = 0
        if selectedAMPM == 0 {
            // AM 12 -> 0
            selectedTimes = hours[selectedHour] == 12 ? 0 : hours[selectedHour]
        }else{
            // PM 12 -> 12
            selectedTimes = hours[selectedHour] == 12 ? 12 : hours[selectedHour] + 12
        }
        print("User Selected Time is \(ampm[selectedAMPM]!) \(hours[row])")
        
        vc?.AMPMHourPickerDidSelectedTime(time: String(selectedTimes))
    }
    
    private func syncAMPMAndHourComponents() {
        let isAM = self.selectedRow(inComponent: 0) == 0
        let currentRow = self.selectedRow(inComponent: 1)
        
        if isAM {
            // 오전일 때
            // 12시에서 11시로 변경하면 오후로 바꾸기
            if selectedHour == 11 && currentRow <= 10 {
                self.selectRow(1, inComponent: 0, animated: true)
            }
        }else{
            // 오후일 때
            // 11시에서 12시로 변경하면 오전으로 바꾸기
            if selectedHour <= 10 && currentRow >= 11 {
                self.selectRow(0, inComponent: 0, animated: true)
            }
        }
    }
}
