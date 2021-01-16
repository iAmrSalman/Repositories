//
//  UIViewExtension.swift
//  AppUIKit
//
//  Created by Amr Salman on 1/16/21.
//

import UIKit

extension UIView {
    public class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        let bundle = Bundle(for: self.self)
        guard
            let nib = bundle.loadNibNamed(name, owner: nil, options: nil)
            else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
            else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}

public enum Shape {
    case rectangle
    case rounded(CGFloat)
    case circular
}

extension UIView {
    var shape: Shape? {
        get {
            if self.layer.cornerRadius == 0 { return .rectangle }
            else if self.layer.cornerRadius == self.bounds.height / 2 { return .circular }
            else { return .rounded(self.layer.cornerRadius) }
        }
        
        set {
            setShape(newValue!)
        }
    }
    
    func setShape(_ shape: Shape) {
        switch shape {
        case .circular:
            circulerContent()
        case .rounded(let cornerRadius):
            self.layer.cornerRadius = cornerRadius
        case .rectangle:
            self.layer.cornerRadius = 0
        }
    }
    
    func circulerContent() {
        self.layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
    }
    
}
