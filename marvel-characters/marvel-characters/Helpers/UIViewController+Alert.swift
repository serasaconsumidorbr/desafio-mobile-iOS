//
//  UIViewController+Alert.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 07/06/21.
//

import UIKit

extension UIViewController {
    func presentWarningAlert(title: String, message: String, buttonTitle: String, action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: action))
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    public func createAnnouncement(with text: String){
        let message = NSAttributedString(
            string: text,
            attributes: [.accessibilitySpeechPitch: 1.0,
                         .accessibilitySpeechQueueAnnouncement: true])
        UIAccessibility.post(notification: .announcement,
                             argument: message)
    }
}
