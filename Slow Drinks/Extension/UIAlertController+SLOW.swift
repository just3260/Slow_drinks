//
//  UIAlertController+SLOW.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/21.
//

import UIKit

extension UIAlertController {
    class func okAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "確定", style: .default, handler: handler))
        return alertController
    }
    
    class func okCancelAlert(title: String?, okTitle: String?, cancelTitle: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okTitle, style: .default, handler: handler))
        alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        return alertController
    }
    
    class func doubleButtonAlert(title: String?, leftTitle: String?, rightTitle: String?, message: String?, leftHandler: ((UIAlertAction) -> Void)? = nil, rightHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: leftTitle, style: .default, handler: leftHandler))
        alertController.addAction(UIAlertAction(title: rightTitle, style: .default, handler: rightHandler))
        return alertController
    }
    
    class func oneButtonAlert(title: String?, message: String?, buttonTitle: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: handler))
        return alertController
    }
    
    class func actionSheet(options: [String], completion:@escaping ((_ index: Int) -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let closure = { (index: Int) in
            { (action: UIAlertAction!) -> Void in
                completion(index)
            }
        }
        var index = 0
        for option in options {
            let action = UIAlertAction(title: option, style: .default, handler: closure(index))
            alertController.addAction(action)
            index += 1
        }
        alertController.addAction(UIAlertAction(title: NSLocalizedString("cancel_button", comment: "Cancel"), style: .destructive, handler: { (action) in
            completion(-1)
        }))
        return alertController
    }
    
    class func toast(_ title: String?, duration: TimeInterval) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.perform(#selector(dismissToast), with: nil, afterDelay: duration)
        return alertController
    }
    
    @objc func dismissToast() {
        self.dismiss(animated: true, completion: nil)
    }
}

