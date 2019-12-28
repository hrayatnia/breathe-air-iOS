//
//  HomeViewDrawer.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-28.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import UIKit
import DrawerKit


extension HomeViewController: UIScrollViewDelegate {}

//extension HomeViewController: DrawerPresentable {
//
////    var heightOfCollapsedDrawer: CGFloat {
////        return 100
////    }
//
////    var fullExpansionBehaviour: DrawerConfiguration.FullExpansionBehaviour? {
////        return .leavesCustomGap(gap: 100)
////    }
//
//}

extension HomeViewController: DrawerAnimationParticipant {
    public var drawerAnimationActions: DrawerAnimationActions {
        let prepareAction: DrawerAnimationActions.PrepareHandler = {
            [weak self] info in
            switch (info.startDrawerState, info.endDrawerState) {
            case (.dismissed, .partiallyExpanded):
                self?.presentedView.prepareCollapsedToPartiallyExpanded()
            case (.partiallyExpanded, .dismissed):
                self?.presentedView.preparePartiallyExpandedToCollapsed()
            case (.dismissed, .fullyExpanded):
                self?.presentedView.prepareCollapsedToFullyExpanded()
            case (.fullyExpanded, .dismissed):
                self?.presentedView.prepareFullyExpandedToCollapsed()
            case (.partiallyExpanded, .fullyExpanded):
                self?.presentedView.preparePartiallyExpandedToFullyExpanded()
            case (.fullyExpanded, .partiallyExpanded):
                self?.presentedView.prepareFullyExpandedToPartiallyExpanded()
            default:
                break
            }
        }

        let animateAlongAction: DrawerAnimationActions.AnimateAlongHandler = {
            [weak self] info in
            switch (info.startDrawerState, info.endDrawerState) {
            case (.dismissed, .partiallyExpanded):
                self?.presentedView.animateAlongCollapsedToPartiallyExpanded()
            case (.partiallyExpanded, .dismissed):
                self?.presentedView.animateAlongPartiallyExpandedToCollapsed()
            case (.dismissed, .fullyExpanded):
                self?.presentedView.animateAlongCollapsedToFullyExpanded()
            case (.fullyExpanded, .dismissed):
                self?.presentedView.animateAlongFullyExpandedToCollapsed()
            case (.partiallyExpanded, .fullyExpanded):
                self?.presentedView.animateAlongPartiallyExpandedToFullyExpanded()
            case (.fullyExpanded, .partiallyExpanded):
                self?.presentedView.animateAlongFullyExpandedToPartiallyExpanded()
            default:
                break
            }
        }

        let cleanupAction: DrawerAnimationActions.CleanupHandler = {
            [weak self] info in
            switch (info.startDrawerState, info.endDrawerState) {
            case (.dismissed, .partiallyExpanded):
                self?.presentedView.cleanupCollapsedToPartiallyExpanded()
            case (.partiallyExpanded, .dismissed):
                self?.presentedView.cleanupPartiallyExpandedToCollapsed()
            case (.dismissed, .fullyExpanded):
                self?.presentedView.cleanupCollapsedToFullyExpanded()
            case (.fullyExpanded, .dismissed):
                self?.presentedView.cleanupFullyExpandedToCollapsed()
            case (.partiallyExpanded, .fullyExpanded):
                self?.presentedView.cleanupPartiallyExpandedToFullyExpanded()
            case (.fullyExpanded, .partiallyExpanded):
                self?.presentedView.cleanupFullyExpandedToPartiallyExpanded()
            default:
                break
            }
        }

        return DrawerAnimationActions(prepare: prepareAction,
                                      animateAlong: animateAlongAction,
                                      cleanup: cleanupAction)
    }
}
