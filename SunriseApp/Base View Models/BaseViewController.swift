import UIKit

class BaseViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.setupActivityIndicator()
    }
    
    
    func showPopUp(title: String? = nil, text: String? = nil, completion: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion?()
        }
        alertController.addAction(okAction)
        if #available(iOS 9.0, *) {
            alertController.preferredAction = okAction
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorPopup(text: String? = nil, completion: (() -> ())? = nil) {
        showPopUp(title: "", text: text, completion: completion)
    }
    
    //MARK: - activity indicator
    func startActivityIndicator() {
        guard activityIndicator != nil else {
            return
        }
        self.view.bringSubviewToFront(activityIndicator!)
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator() {
        UIApplication.shared.endIgnoringInteractionEvents()
        activityIndicator?.isHidden = true
        activityIndicator?.stopAnimating()
    }
    
    //MARK: - private
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        self.view.addSubview(activityIndicator!)
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: activityIndicator!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerY = NSLayoutConstraint(item: activityIndicator!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([centerY, centerX])
        view.layoutIfNeeded()
        activityIndicator?.color = UIColor.lightGray
        activityIndicator?.isHidden = true
    }
}


