//
//  ContentViewLifeCycle.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/10/24.
//

import UIKit
import SwiftUI
import Combine

enum LifeCycle {
    case viewDidLoad
    case viewWillAppaer
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear
}

protocol LifeCycleHandlerProtocol: AnyObject {
    var lifeCycle: PassthroughSubject<LifeCycle, Never> { get }
}

final class LifeCycleController: NiblessViewController {
    
    private weak var handler: LifeCycleHandlerProtocol?
    
    init(handler: LifeCycleHandlerProtocol) {
        self.handler = handler
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handler?.lifeCycle.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handler?.lifeCycle.send(.viewWillAppaer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handler?.lifeCycle.send(.viewDidAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        handler?.lifeCycle.send(.viewWillDisappear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        handler?.lifeCycle.send(.viewDidDisappear)
    }
    
    deinit {
        print(self, #function)
    }
    
    struct Representable: UIViewControllerRepresentable {
        typealias UIViewControllerType = LifeCycleController
        private let handler: LifeCycleHandlerProtocol
        
        init(handler: LifeCycleHandlerProtocol) {
            self.handler = handler
        }
        
        func makeUIViewController(context: Context) -> LifeCycleController {
            LifeCycleController(handler: handler)
        }
        
        func updateUIViewController(_ uiViewController: LifeCycleController, context: Context) {
            
        }
    }
}

class NiblessViewController: UIViewController {
    // MARK: - Methods
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}
