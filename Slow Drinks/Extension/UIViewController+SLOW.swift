//
//  UIViewController+SLOW.swift
//  Slow Drinks
//
//  Created by Andrew Wang on 2021/4/21.
//

import UIKit

extension UIViewController {
    func showLoading() {
        DispatchQueue.main.async {
            LoadingView.sharedInstance.startLoading(in: self.view)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            LoadingView.sharedInstance.stopLoading()
        }
    }
}
