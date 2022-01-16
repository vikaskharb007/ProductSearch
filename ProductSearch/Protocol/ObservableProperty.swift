//
//  ObservableProperty.swift
//  ProductSearch
//
//  Created by Vikas Kharb on 15/01/2022.
//

import Foundation


class ObservableProperty<T> {
    typealias ObserverCallback = (T) -> Void
    
    struct Observer<T> {
        weak var observer: AnyObject?
        let notifyCallback: ObserverCallback
    }
    
    private var observers: [Observer<T>] = .init()
    
    var value: T {
        didSet{
            informObservers()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func addObserver(on observer: AnyObject, notifyBlock: @escaping ObserverCallback) {
        observers.append(Observer(observer: observer, notifyCallback: notifyBlock))
    }
    
    func removeObserver( _ observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    private func informObservers() {
        observers.forEach { observer in
            observer.notifyCallback(self.value)
        }
    }
}
