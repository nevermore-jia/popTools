//
//  PopPresentationController.swift
//  ZYPopAnimator
//
//  Created by 因巴斯 on 2018/2/8.
//  Copyright © 2018年 nevermore. All rights reserved.
//

import UIKit

class PopPresentationController: UIPresentationController {
    var presentFrame: CGRect?//菜单大小
    
    
    /// 背景
    lazy var coverView: UIView={
        let view = UIView.init(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.init(white: 0.0, alpha: 0.3)
        let ges = UITapGestureRecognizer.init(target: self, action: #selector(dismiss))
        view.addGestureRecognizer(ges)
        return view
    }()
    
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = presentFrame!
        containerView?.insertSubview(coverView, at: 0)
    }
    
    /// 消失
    @objc func dismiss() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
