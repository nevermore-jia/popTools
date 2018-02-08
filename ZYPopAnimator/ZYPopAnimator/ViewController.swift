//
//  ViewController.swift
//  ZYPopAnimator
//
//  Created by 因巴斯 on 2018/2/8.
//  Copyright © 2018年 nevermore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: lazy
    lazy var popviewAnimator: PopViewAnimator = {
        let animator = PopViewAnimator()
        animator.presentFrame = CGRect(x: 0, y: kScreentHeight-310, width: kScreentWidth, height: 310)
        animator.animationStyle = .bottom
        return animator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = PickerController()
        vc.transitioningDelegate = popviewAnimator
        vc.modalPresentationStyle = .custom
        vc.noticeText = "请选择性别"
        vc.dataArr = ["男","女","不限"]
        vc.didmissSelect = {
            (titleName: String?) -> Void in
            print(titleName!)
        }
        present(vc, animated: true, completion: nil)
    }
}

