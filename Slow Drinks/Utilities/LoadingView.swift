//
//  LoadingView.swift
//  INSTO Tap
//
//  Created by Laura Wang on 2020/7/10.
//  Copyright © 2020 INSTO. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    static let sharedInstance: LoadingView = {
        let instance = LoadingView()
        instance.setupUI()
        return instance
    }()
    
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    private var top = NSLayoutConstraint()
    private var bottom = NSLayoutConstraint()
    private var leading = NSLayoutConstraint()
    private var trailing = NSLayoutConstraint()
    
    private func setupUI() {
        backgroundColor = .clear
        self.isUserInteractionEnabled = true
        setupIndicator()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func setupIndicator() {
        self.indicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicator)
        
        let centerX = NSLayoutConstraint(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: indicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.addConstraints([centerX, centerY])
    }
    
    func startLoading(in view: UIView) {
        DispatchQueue.main.async {
            self.frame = view.frame
            self.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(self)
            
            self.top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            self.bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            self.leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
            self.trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            view.addConstraints([self.top, self.bottom, self.leading, self.trailing])
            self.indicator.startAnimating()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            if let view = self.superview {
                view.removeConstraints([self.top, self.bottom, self.leading, self.trailing])
            }
            self.indicator.stopAnimating()
            self.removeFromSuperview()
        }
    }
    
    func startLoading() {
        guard let vc = currentViewController() else {return}
        self.startLoading(in: vc.view)
    }
}

extension LoadingView {
    func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
