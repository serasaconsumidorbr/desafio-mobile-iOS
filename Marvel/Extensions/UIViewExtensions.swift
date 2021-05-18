//
//  UIViewExtensions.swift
//  Marvel
//
//  Created by João Pedro on 21/04/21.
//
 
import UIKit

public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

public struct AnchorParameter<T: AnyObject> {
    let anchor: T
    let padding: CGFloat
    var constraintType: NSLayoutAnchor<T>.ConstraintType = .equal
}

public extension UIView {
    struct Constraint {
        public var centerX: NSLayoutConstraint? { didSet { centerX?.isActive = true } }
        public var centerY: NSLayoutConstraint? { didSet { centerY?.isActive = true } }
        public var top: NSLayoutConstraint? { didSet { top?.isActive = true } }
        public var left: NSLayoutConstraint? { didSet { left?.isActive = true } }
        public var right: NSLayoutConstraint? { didSet { right?.isActive = true } }
        public var bottom: NSLayoutConstraint? { didSet { bottom?.isActive = true } }
        public var width: NSLayoutConstraint? { didSet { width?.isActive = true } }
        public var height: NSLayoutConstraint? { didSet { height?.isActive = true } }
    }

    @discardableResult
    func anchor(centerX: AnchorParameter<NSLayoutXAxisAnchor>? = nil,
                centerY: AnchorParameter<NSLayoutYAxisAnchor>? = nil,
                top: AnchorParameter<NSLayoutYAxisAnchor>? = nil,
                left: AnchorParameter<NSLayoutXAxisAnchor>? = nil,
                right: AnchorParameter<NSLayoutXAxisAnchor>? = nil,
                bottom: AnchorParameter<NSLayoutYAxisAnchor>? = nil,
                width: CGFloat? = nil,
                height: CGFloat? = nil) -> Constraint {
        self.translatesAutoresizingMaskIntoConstraints = false

        var constraint = Constraint()

        if let centerX = centerX { constraint.centerX = centerXAnchor.constraint(anchor: centerX.anchor,
                                                                                 constant: centerX.padding,
                                                                                 type: centerX.constraintType) }

        if let centerY = centerY { constraint.centerY = centerYAnchor.constraint(anchor: centerY.anchor,
                                                                                 constant: centerY.padding,
                                                                                 type: centerY.constraintType) }

        if let top = top { constraint.top = topAnchor.constraint(anchor: top.anchor,
                                                                 constant: top.padding,
                                                                 type: top.constraintType) }

        if let left = left { constraint.left = leftAnchor.constraint(anchor: left.anchor,
                                                                     constant: left.padding,
                                                                     type: left.constraintType) }

        if let right = right { constraint.right = rightAnchor.constraint(anchor: right.anchor,
                                                                         constant: -right.padding,
                                                                         type: right.constraintType) }

        if let bottom = bottom { constraint.bottom = bottomAnchor.constraint(anchor: bottom.anchor,
                                                                             constant: -bottom.padding,
                                                                             type: bottom.constraintType) }

        if let width = width { constraint.width = widthAnchor.constraint(equalToConstant: width) }
        if let height = height { constraint.height = heightAnchor.constraint(equalToConstant: height) }

        return constraint
    }

    @discardableResult
    func anchorFillSuperView(padding: CGFloat = 0, inSafeArea: Bool = true) -> Constraint {
        var constraint = Constraint()
        if let superview = superview{
            if inSafeArea {
                if #available(iOS 11.0, *) {
                    constraint = anchor(
                        top: AnchorParameter<NSLayoutYAxisAnchor>(anchor: superview.safeAreaLayoutGuide.topAnchor, padding: padding),
                        left: AnchorParameter<NSLayoutXAxisAnchor>(anchor: superview.leftAnchor, padding: padding),
                        right: AnchorParameter<NSLayoutXAxisAnchor>(anchor: superview.rightAnchor, padding: padding),
                        bottom: AnchorParameter<NSLayoutYAxisAnchor>(anchor: superview.safeAreaLayoutGuide.bottomAnchor, padding: padding)
                    )
                } else {
                    constraint = anchor(
                        top: AnchorParameter<NSLayoutYAxisAnchor>(anchor: superview.topAnchor, padding: padding),
                        left: AnchorParameter<NSLayoutXAxisAnchor>(anchor: superview.leftAnchor, padding: padding),
                        right: AnchorParameter<NSLayoutXAxisAnchor>(anchor: superview.rightAnchor, padding: padding),
                        bottom: AnchorParameter<NSLayoutYAxisAnchor>(anchor: superview.bottomAnchor, padding: padding)
                    )
                }
            } else {
                constraint = anchor(
                    top: AnchorParameter<NSLayoutYAxisAnchor>(anchor: superview.topAnchor, padding: padding),
                    left: AnchorParameter<NSLayoutXAxisAnchor>(anchor: superview.leftAnchor, padding: padding),
                    right: AnchorParameter<NSLayoutXAxisAnchor>(anchor: superview.rightAnchor, padding: padding),
                    bottom: AnchorParameter<NSLayoutYAxisAnchor>(anchor: superview.bottomAnchor, padding: padding)
                )
            }
        }
        return constraint
    }
}

public extension NSLayoutAnchor {
    enum ConstraintType {
        case equal, greaterThanOrEqual, lessThanOrEqual
    }
}

public extension NSLayoutXAxisAnchor {
    func constraint(anchor: NSLayoutXAxisAnchor, constant c: CGFloat, type: ConstraintType) -> NSLayoutConstraint {
        switch type {
        case .equal:
            return constraint(equalTo: anchor, constant: c)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: c)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: c)
        }
    }
}

public extension NSLayoutYAxisAnchor {
    func constraint(anchor: NSLayoutYAxisAnchor, constant c: CGFloat, type: ConstraintType) -> NSLayoutConstraint {
        switch type {
        case .equal:
            return constraint(equalTo: anchor, constant: c)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: anchor, constant: c)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: anchor, constant: c)
        }
    }
}
