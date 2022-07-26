//
//  Coordinator.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit



public protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    
    var topViewController: UIViewController? { get set }
    
    var parent: Coordinator? { get set }
    
    var children: [Coordinator]? { get set }
    
    init(_ navigationController: UINavigationController)
    
    func start()
}


public extension Coordinator {
    
    
    func finish() {
        if let children = children {
            children.forEach { child in
                detachChildWithIdentifier(child.identifier)
            }
        }
        parent?.detachChildWithIdentifier(self.identifier)
    }
    
    
    @discardableResult
    func attachChild(_ child: Coordinator, completion: (() -> ())? = nil) -> Bool {
        if children?.first(where: { $0.identifier == child.identifier }) != nil {
            return false
        }
        child.parent = self
        children?.append(child)
        completion?()
        return true
    }
    
    @discardableResult
    func detachChildWithIdentifier(_ childIdentifier: String, completion: (() -> ())? = nil) -> Bool {
        guard let childToDettachIndex = children?.firstIndex(where: { $0.identifier == childIdentifier }) else {
            return false
        }
        children?[childToDettachIndex].finish()
        children?.remove(at: childToDettachIndex)
        completion?()
        return true
    }
    
    var identifier: String {
        return String(describing: type(of: self))
    }
    
}
