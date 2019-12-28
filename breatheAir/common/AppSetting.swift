//
//  AppSetting.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
struct AppSetting {
    static let APIVersion: String = "/api"
    static let APIToken: String = ""

    //static let baseTheme: AppTheme = .light
    static let BaseURL: String = {
        #if Release || AdHoc
        return "https://breatherair.herokuapp.com"
        #elseif Debug
        return "https://breatherair.herokuapp.com"
        #endif
        return "https://breatherair.herokuapp.com"

    } ()
}
