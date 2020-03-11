//
//  Extensions.swift
//  NYTimesPopularArticles
//
//  Created by Venugopalan, Vimal on 11/03/20.
//  Copyright © 2020 Venugopalan, Vimal. All rights reserved.
//

import UIKit

extension UIViewController{
    /// Showing alert for generic messages with action
    ///
    /// - Parameters:
    ///   - title: title of the message
    ///   - message: message body
    ///   - completionHandler: optional action handler
    func showAlert(withTitle title: String, message : String, completionHandler:(() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { action in
            if let actionHandler = completionHandler{
                actionHandler()
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        return alertController
    }
        
    /// Activity Indicator start animation
    func activityStartAnimating() {
        var activityIndicator:UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            // Fallback on earlier versions
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.isUserInteractionEnabled = false
        
        self.view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    /// Activity Indicator stop animation
    func activityStopAnimating() {
        for view in self.view.subviews {
            if let subView = view as? UIActivityIndicatorView {
                subView.removeFromSuperview()
                break
            }
        }
        self.view.isUserInteractionEnabled = true
    }
}
