//
//  Storyboard.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//
import Foundation
import UIKit

struct Storyboard {
    static let main = UIStoryboard(name: "Main", bundle: nil)

}

extension UIStoryboard {
    func instantiate<T: UIViewController>(_: T.Type) -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardId) as? T
            else {
                fatalError("Could not instantiate ViewController: \(T.self) with storyboardID: \(T.storyboardId)")
        }
        return viewController
    }
}

protocol StoryboardReferencable: class { }

extension StoryboardReferencable where Self: UIViewController {
    static var storyboardId: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardReferencable { }
