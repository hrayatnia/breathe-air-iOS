//
//  PresentedNavigationController.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-28.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import UIKit
import DrawerKit

class PresentedNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
}

extension PresentedNavigationController: DrawerAnimationParticipant {
    var drawerAnimationActions: DrawerAnimationActions {
        return (topViewController as? DrawerAnimationParticipant)?.drawerAnimationActions
            ?? DrawerAnimationActions()
    }
}

extension PresentedNavigationController: DrawerPresentable {
    var heightOfCollapsedDrawer: CGFloat {
        return (topViewController as? DrawerPresentable)?.heightOfCollapsedDrawer ?? 0.0
    }

    var heightOfPartiallyExpandedDrawer: CGFloat {
        return (topViewController as? DrawerPresentable)?.heightOfPartiallyExpandedDrawer ?? 0.0
    }

    
}

extension PresentedNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let viewController = viewController as? HomeViewController {
            drawerPresentationController?.scrollViewForPullToDismiss = viewController.presentedView
        }
    }
}

