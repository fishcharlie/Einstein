//
//  Observable.swift
//  Einstein
//
//  Created by Charlie Fish on 5/30/19.
//

import Foundation

private protocol ObservableClass {
    associatedtype ValueType
    associatedtype ListenerClosure

    var value: ValueType { get set }
}

final class Observable<T>: ObservableClass {
    typealias ValueType = T
    typealias ListenerClosure = (_ new: T, _ old: T?) -> Void

    private var observers: [ListenerClosure] = []

    init(_ value: T) {
        self.value = value
    }

    var value: T {
        didSet {
            notify(new: value, old: oldValue)
        }
    }

    func addObserver(fire: Bool = false, _ closure: @escaping ListenerClosure) {
        observers.append(closure)

        if fire {
            notify(new: value, old: nil)
        }
    }

    private func notify(new: T, old: T?) {
        observers.forEach { closure in
            closure(new, old)
        }
    }
}
