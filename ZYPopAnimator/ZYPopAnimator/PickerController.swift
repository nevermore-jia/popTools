//
//  PickerController.swift
//  ZYPopAnimator
//
//  Created by 因巴斯 on 2018/2/8.
//  Copyright © 2018年 nevermore. All rights reserved.
//

import UIKit

class PickerController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = noticeText
        }
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    var noticeText: String?
    var dataArr: Array<String>?
    var didmissSelect: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// 取消
    @IBAction func cancleBtnClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// 确定
    @IBAction func sureBtnClicked() {
        if didmissSelect != nil {
            let selectRow = pickerView.selectedRow(inComponent: 0)
            didmissSelect!(dataArr![selectRow])
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - <#UIPickerViewDelegate, UIPickerViewDataSource#>
extension PickerController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let a = dataArr?.count {
            return a
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArr?[row]
    }
}
