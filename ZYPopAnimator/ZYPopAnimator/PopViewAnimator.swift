//
//  PopViewAnimator.swift
//  ZYPopAnimator
//
//  Created by 因巴斯 on 2018/2/8.
//  Copyright © 2018年 nevermore. All rights reserved.
//

import UIKit

enum PopAnimationStyle : Int {
    case bottom
    case right
    case alert
    case dropDown
}

/// 屏幕宽度
let kScreentWidth = UIScreen.main.bounds.width
/// 屏幕高度
let kScreentHeight = UIScreen.main.bounds.height

class PopViewAnimator: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    var presentFrame: CGRect?
    var isPresnet: Bool?
    var animationStyle: PopAnimationStyle?
    
    
    /// 要专场的vc
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentVc = PopPresentationController(presentedViewController: presented, presenting: presenting)
        presentVc.presentFrame = presentFrame
        return presentVc
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresnet = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresnet = false
        return self
    }
    
    /// 动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    /// 动画形式
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        switch animationStyle {
        case .bottom?:
            y = kScreentHeight
            break
        case .right?:
            x = kScreentWidth
            break
        default:
            break
        }
        
        if isPresnet! {//展开
            let toView = transitionContext.view(forKey: .to)
            if animationStyle == .alert {
                toView?.transform=CGAffineTransform(scaleX: 0.0, y: 0.0)
            }else if animationStyle == .dropDown {
                toView?.transform=CGAffineTransform(scaleX: 1.0, y: 0.0)
                toView?.layer.anchorPoint = CGPoint(x: 0, y: 0)
            }else{
                toView?.frame = CGRect(x: x, y: y, width: toView!.width, height: toView!.height)
            }
            
            transitionContext.containerView.addSubview(toView!)
            
            //执行动画
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                if  self.animationStyle == .bottom {
                    toView?.frame = CGRect(x: x, y: y-self.presentFrame!.size.height, width: toView!.width, height: toView!.height)
                }else if  self.animationStyle == .right {
                    toView?.frame = CGRect(x: x-self.presentFrame!.size.width, y: y, width: toView!.width, height: toView!.height)
                }else{
                    toView?.transform = CGAffineTransform.identity;
                }
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }else{//关闭
            
            let fromView = transitionContext.view(forKey: .from)
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                if self.animationStyle == .alert {
                    fromView?.transform=CGAffineTransform(scaleX: 0.0, y: 0.0)
                }else if self.animationStyle == .dropDown {
                    fromView?.transform=CGAffineTransform(scaleX: 1.0, y: 0.0)
                }else{
                    fromView?.frame = CGRect(x: x, y: y, width: fromView!.width, height: fromView!.height)
                }
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
    }
    

}


// MARK: - UIVIew扩展
extension UIView {
    
    /// width
    var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            self.frame.size.width=width
        }
    }
    
    /// height
    var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            self.frame.size.width=height
        }
    }
    
}
