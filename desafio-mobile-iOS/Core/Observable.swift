//
//  Observable.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

public final class Observable<Value> {

    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }

    private var observers = [Observer<Value>]()

    private(set) var value: Value?

    func onNext(_ value: Value) {
        self.value = value
        notifyObservers()
    }

    func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        guard let value = value else { return }
        observerBlock(value)
    }

    func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }

    private func notifyObservers() {
        for observer in observers {
            guard let value = value else { return }
            DispatchQueue.main.async { observer.block(value) }
        }
    }
}
