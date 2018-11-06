
import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerScale: CGFloat = 2 {
        didSet {
            setupUI()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setupUI()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black
    
    func setupUI() {
        clipsToBounds = true
        backgroundColor = .clear
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = self.bounds.height / cornerScale
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / cornerScale
    }
    
}
