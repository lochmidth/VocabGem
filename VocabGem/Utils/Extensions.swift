//
//  Extensions.swift
//  VocabGem
//
//  Created by Alphan Ogün on 27.12.2023.
//



import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static let blueStone = rgb(red: 96, green: 114, blue: 116)
    static let warmIvory = rgb(red: 250, green: 238, blue: 209)
    static let beigeMist = rgb(red: 222, green: 208, blue: 182)
    static let mutedTaupe = rgb(red: 178, green: 165, blue: 155)
    
}

extension UIViewController {
    
   
}

//extension URL {
//    var queryParameters: [String: String]? {
//        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
//              let queryItems = components.queryItems else {
//            return nil
//        }
//
//        var parameters = [String: String]()
//        for item in queryItems {
//            parameters[item.name] = item.value
//        }
//
//        return parameters
//    }
//}

extension UIView {
    
//    func inputContainerView(image: UIImage?, textField: UITextField? = nil, segmentedControl: UISegmentedControl? = nil ) -> UIView {
//        let view = UIView()
//        
//        let imageView = UIImageView()
//        imageView.image = image
//        imageView.alpha = 0.87
//        view.addSubview(imageView)
//        
//        if let textField {
//            imageView.centerY(inView: view)
//            imageView.anchor(left: view.leftAnchor, paddingLeft: 18, width: 24, height: 24)
//            
//            view.addSubview(textField)
//            textField.centerY(inView: view)
//            textField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
//            
//            view.setHeight(50)
//        }
//        
//        if let segmentedControl {
//            imageView.anchor(top: view.topAnchor, left: view.leftAnchor,
//                             paddingTop: -8 ,paddingLeft: 18, width: 24, height: 24)
//            view.addSubview(segmentedControl)
//            segmentedControl.anchor(left: view.leftAnchor, right: view.rightAnchor,
//                                    paddingLeft: 8, paddingRight: 8)
//            segmentedControl.centerY(inView: view, constant: 8)
//            
//            view.setHeight(80)
//        }
//        
//        let separatorView = UIView()
//        separatorView.backgroundColor = .lightGray
//        view.addSubview(separatorView)
//        separatorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
//                             paddingLeft: 10, paddingRight: 10, height: 0.75)
//        
//        return view
//    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.55
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
        
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}
//
//extension UITableViewCell {
//    var selectionColor: UIColor {
//        set {
//            let view = UIView()
//            view.backgroundColor = newValue
//            self.selectedBackgroundView = view
//        }
//        get {
//            return self.selectedBackgroundView?.backgroundColor ?? UIColor.clear
//        }
//    }
//}

