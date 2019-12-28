//
//  HomeView.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-28.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import UIKit

class HomeView: UIScrollView {

}

extension HomeView {
    func prepareCollapsedToPartiallyExpanded() {
      
    }

    func animateAlongCollapsedToPartiallyExpanded() {
       
    }

    func cleanupCollapsedToPartiallyExpanded() {
        animateAlongCollapsedToPartiallyExpanded()
    }

    func preparePartiallyExpandedToCollapsed() {
        animateAlongCollapsedToPartiallyExpanded()
    }

    func animateAlongPartiallyExpandedToCollapsed() {
        prepareCollapsedToPartiallyExpanded()
    }

    func cleanupPartiallyExpandedToCollapsed() {
        prepareCollapsedToPartiallyExpanded()
    }
}

extension HomeView {
    func preparePartiallyExpandedToFullyExpanded() {
    }

    func animateAlongPartiallyExpandedToFullyExpanded() {
    
    }

    func cleanupPartiallyExpandedToFullyExpanded() {
        animateAlongPartiallyExpandedToFullyExpanded()
    }

    func prepareFullyExpandedToPartiallyExpanded() {
        animateAlongPartiallyExpandedToFullyExpanded()
    }

    func animateAlongFullyExpandedToPartiallyExpanded() {
        preparePartiallyExpandedToFullyExpanded()
    }

    func cleanupFullyExpandedToPartiallyExpanded() {
        preparePartiallyExpandedToFullyExpanded()
    }
}

extension HomeView {
    func prepareCollapsedToFullyExpanded() {

    }

    func animateAlongCollapsedToFullyExpanded() {
    
    }

    func cleanupCollapsedToFullyExpanded() {
        animateAlongCollapsedToFullyExpanded()
    }

    func prepareFullyExpandedToCollapsed() {
        animateAlongCollapsedToFullyExpanded()
    }

    func animateAlongFullyExpandedToCollapsed() {
        prepareCollapsedToFullyExpanded()
    }

    func cleanupFullyExpandedToCollapsed() {
        prepareCollapsedToFullyExpanded()
    }
}
