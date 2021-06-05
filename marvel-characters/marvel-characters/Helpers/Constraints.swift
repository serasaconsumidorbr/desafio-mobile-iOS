//
//  Constraints.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

public typealias AnchorX = (anchor: NSLayoutXAxisAnchor, distance: CGFloat)
public typealias AnchorY = (anchor: NSLayoutYAxisAnchor, distance: CGFloat)
public typealias AnchorSize = (anchor: NSLayoutDimension, distance: CGFloat, multiplier: CGFloat)

public final class Constraints {
    
    public var centerX: NSLayoutConstraint? { didSet { centerX?.isActive = true } }
    public var centerY: NSLayoutConstraint? { didSet { centerY?.isActive = true } }
    public var top: NSLayoutConstraint? { didSet { top?.isActive = true } }
    public var leading: NSLayoutConstraint? { didSet { leading?.isActive = true } }
    public var trailing: NSLayoutConstraint? { didSet { trailing?.isActive = true } }
    public var left: NSLayoutConstraint? { didSet { left?.isActive = true } }
    public var right: NSLayoutConstraint? { didSet { right?.isActive = true } }
    public var bottom: NSLayoutConstraint? { didSet { bottom?.isActive = true } }
    public var width: NSLayoutConstraint? { didSet { width?.isActive = true } }
    public var height: NSLayoutConstraint? { didSet { height?.isActive = true } }
    public var anchorWidth: NSLayoutConstraint? { didSet { anchorWidth?.isActive = true } }
    public var anchorHeight: NSLayoutConstraint? { didSet { anchorHeight?.isActive = true } }
    
    public init (
        centerX: NSLayoutConstraint? = nil,
        centerY: NSLayoutConstraint? = nil,
        top: NSLayoutConstraint? = nil,
        leading: NSLayoutConstraint? = nil,
        trailing: NSLayoutConstraint? = nil,
        left: NSLayoutConstraint? = nil,
        right: NSLayoutConstraint? = nil,
        bottom: NSLayoutConstraint? = nil,
        width: NSLayoutConstraint? = nil,
        height: NSLayoutConstraint? = nil,
        anchorWidth: NSLayoutConstraint? = nil,
        anchorHeight: NSLayoutConstraint? = nil
    ) {
        self.centerX = centerX
        self.centerY = centerY
        self.top = top
        self.leading = leading
        self.trailing = trailing
        self.left = left
        self.right = right
        self.bottom = bottom
        self.width = width
        self.height = height
        self.anchorWidth = anchorWidth
        self.anchorHeight = anchorHeight
        
        centerX?.isActive = true
        centerY?.isActive = true
        top?.isActive = true
        leading?.isActive = true
        trailing?.isActive = true
        left?.isActive = true
        right?.isActive = true
        bottom?.isActive = true
        width?.isActive = true
        height?.isActive = true
        anchorWidth?.isActive = true
        anchorHeight?.isActive = true
    }
}

extension UIView {
    
    fileprivate func bind(anchorX: AnchorX?, selfAnchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint? {
           guard let anchorX = anchorX else { return nil }
           return anchorX.anchor.constraint (
               equalTo: selfAnchor,
               constant: anchorX.distance
           )
       }
       
       fileprivate func bind(anchorY: AnchorY?, selfAnchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint? {
           guard let anchorY = anchorY else { return nil }
           return anchorY.anchor.constraint(
               equalTo: selfAnchor,
               constant: anchorY.distance
           )
       }
       
       fileprivate func bind(anchorSize: AnchorSize?, selfAnchor: NSLayoutDimension) -> NSLayoutConstraint? {
           guard let anchorSize = anchorSize else { return nil }
           return selfAnchor.constraint(
               equalTo: anchorSize.anchor,
               multiplier: anchorSize.multiplier,
               constant: anchorSize.distance
           )
       }
       
       fileprivate func bind(size: CGFloat?, selfAnchor: NSLayoutDimension) -> NSLayoutConstraint? {
           guard let size = size else { return nil }
           return selfAnchor.constraint(equalToConstant: size)
       }
    
    @discardableResult
    public func anchor (
        centerX: AnchorX?  = nil,
        centerY: AnchorY?  = nil,
        top: AnchorY?  = nil,
        leading: AnchorX?  = nil,
        trailing: AnchorX?  = nil,
        left: AnchorX?  = nil,
        right: AnchorX?  = nil,
        bottom: AnchorY?  = nil,
        width: CGFloat?  = nil,
        height: CGFloat?  = nil,
        anchorWidth: AnchorSize? = nil,
        anchorHeight: AnchorSize? = nil
        ) -> Constraints {
        guard width == nil || anchorWidth == nil else {
            fatalError("WidthError: width and anchorWidth set at the same call")
        }
        
        guard height == nil || anchorHeight == nil else {
            fatalError("HeightError: height and anchorHeight set at the same call")
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var newTop: AnchorY?
        if let top = top {
            newTop = top
            newTop?.distance *= -1
        }
        
        var newLeading: AnchorX?
        if let leading = leading {
            newLeading = leading
            newLeading?.distance *= -1
        }
        
        var newLeft: AnchorX?
        if let left = left {
            newLeft = left
            newLeft?.distance *= -1
        }
        
        return Constraints (
            centerX: bind(anchorX: centerX, selfAnchor: centerXAnchor),
            centerY: bind(anchorY: centerY, selfAnchor: centerYAnchor),
            top: bind(anchorY: newTop, selfAnchor: topAnchor),
            leading: bind(anchorX: newLeading, selfAnchor: leadingAnchor),
            trailing: bind(anchorX: trailing, selfAnchor: trailingAnchor),
            left: bind(anchorX: newLeft, selfAnchor: leftAnchor),
            right: bind(anchorX: right, selfAnchor: rightAnchor),
            bottom: bind(anchorY: bottom, selfAnchor: bottomAnchor),
            width: bind(size: width, selfAnchor: widthAnchor),
            height: bind(size: height, selfAnchor: heightAnchor),
            anchorWidth: bind(anchorSize: anchorWidth, selfAnchor: widthAnchor),
            anchorHeight: bind(anchorSize: anchorHeight, selfAnchor: heightAnchor)
        )
    }
}
