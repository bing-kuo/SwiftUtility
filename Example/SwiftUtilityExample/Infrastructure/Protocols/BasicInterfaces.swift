//
//  BasicInterfaces.swift
//  SwiftUtilityExample
//
//  Created by Bing Kuo on 2024/2/18.
//

import Foundation
import UIKit

// View

protocol ViewInterface: AnyObject { }

// Interactor

protocol InteractorInterface: AnyObject { }

// Presenter

protocol PresenterInterface: AnyObject { }

// Router

protocol RouterInterface: AnyObject {
    var viewController: UIViewController { get }
}

extension RouterInterface {
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    func present(_ router: RouterInterface, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.present(router.viewController, animated: animated, completion: completion)
    }
    
    func push(_ router: RouterInterface, animated: Bool = true) {
        navigationController?.pushViewController(router.viewController, animated: animated)
    }
}
