//
//  UIViewController+Extension.swift
//  OpahGit
//
//  Created by Thiago Santiago on 23/05/21.
//

import UIKit

class BaseViewController: UIViewController {
    private let loaderView: UIView = UIView()
    private let loader: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loader.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.loaderView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        self.loaderView.addSubview(self.loader)
    }
    
    func showLoader() {
        self.loaderView.frame = UIScreen.main.bounds
        self.loader.center = self.loaderView.center
        
        DispatchQueue.main.async {
            self.loader.startAnimating()
            self.view.addSubview(self.loaderView)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.loaderView.removeFromSuperview()
        }
    }
    
    func showError(title: String, message: String) {
        // Create the alert controller
            let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)

            // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }

            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)

            // Present the controller
            self.present(alertController, animated: true, completion: nil)
    }
}
