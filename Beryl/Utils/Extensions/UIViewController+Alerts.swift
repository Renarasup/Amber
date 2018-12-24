//
//  UIViewController+Alerts.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 23.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /// Shows an alert message
    public func showAlert(title: String, message: String = "", completion: @escaping (() -> ())) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {  (_) in
            
            completion()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    public func alert(title: String? = nil, message: String? = nil, cancelable: Bool = false, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(.okAction(handler))
        
        if cancelable {
            alertController.addAction(.cancelAction())
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    public func alert(error: Error, cancelable: Bool = false, handler: ((UIAlertAction) -> Void)? = nil) {
        let title = "Error"
        
        #if DEBUG
        let message = (error as NSError).userInfo[NSDebugDescriptionErrorKey] as? String ?? error.localizedDescription
        #else
        let message = error.localizedDescription
        #endif
        
        alert(title: title, message: message, cancelable: cancelable, handler: handler)
    }
    
}

extension UIAlertAction {
    public class func okAction(_ handler: ((_ action: UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "Ok", style: .default, handler: handler)
    }
    
    public class func cancelAction(_ handler: ((_ action: UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
    }
}

