import UIKit

extension CALayer {
    open override func setValue(_ value: Any?, forKey key: String) {
        guard key == "borderColor", let color = value as? UIColor else {
            super.setValue(value, forKey: key)
            return
        }
        
        self.borderColor = color.cgColor
    }
}

