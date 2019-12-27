//
//  StateType.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import UIKit

enum StatusType: String {
    case healthy = "healthy"
    case moderate = "moderate"
    case sensetive = "sensetive"
    case unhealthy = "unhealthy"
    case veryUnhealthy = "very unhealthy"
    case hazardous = "hazardous"
    static func getType(by value: Double) -> StatusType {
        if value > 0 && value < 51 {
            return StatusType.healthy
        }else if value < 101 {
            return StatusType.moderate
        }else if value < 151 {
            return StatusType.sensetive
        }else if value < 200 {
            return StatusType.unhealthy
        }else if value < 300 {
            return StatusType.veryUnhealthy
        } else {
            return StatusType.hazardous
        }
    }
    func getColor(type: StatusType) -> String {
        switch type {
        case .healthy:
            return AppColor.WildCaribbeinGreen.toHexString()
        case .moderate:
            return AppColor.BleuDeFrance.toHexString()
        case .sensetive:
            return AppColor.DoubleDragonSkin.toHexString()
        case .unhealthy:
            return AppColor.Amour.toHexString()
        case .veryUnhealthy:
            return AppColor.BlueBell.toHexString()
        case .hazardous:
            return AppColor.ImperialPrimer.toHexString()
            
        }
    }
    
    func getImageAsset(type: StatusType ) -> UIImage {
        switch type {
        case .healthy:
            return #imageLiteral(resourceName: "fall-in-love")
        case .moderate:
            return #imageLiteral(resourceName: "winking-face")
        case .sensetive:
            return #imageLiteral(resourceName: "anxious")
        case .unhealthy:
            return #imageLiteral(resourceName: "vomit")
        case .veryUnhealthy:
            return #imageLiteral(resourceName: "expressions")
        case .hazardous:
            return #imageLiteral(resourceName: "dizzy")
        }
    }
}
