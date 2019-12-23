//
//  Device.swift
//  breatheAir
//
//  Created by Amir Hesam Rayatnia on 2019-12-24.
//  Copyright © 2019 Amir Hesam Rayatnia. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Device Structure
struct Device {

    // MARK: - Singletons
    static var TheCurrentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
    
    static let hasNotch: Bool = {
        return UIDevice.hasNotch
    }()
    
    static let TheCurrentDeviceBound: CGRect = {
        return UIScreen.main.bounds
    }()
    
    static let statusBarHeight: CGFloat = {
        return UIApplication.shared.statusBarFrame.height
    }()


    static let isTesting: Bool = {
        let environment = ProcessInfo().environment
        return (environment["XCInjectBundleInto"] != nil)
    }()

    static let vendorIdString: String = {
        if isSimulator() || isTesting {
            return "149733CB-B5E7-48C7-9352-4581C21AC7F1"
        } else {
            return UIDevice.current.identifierForVendor?.uuidString ?? ""
        }
    }()

    static var TheCurrentDeviceVersion: Float {
        struct Singleton {
            static let version: Float = {
                return Float(UIDevice.current.systemVersion) ?? 10.0
            }()
        }
        return Singleton.version
    }
    static let osVersion: String = {
        return UIDevice.current.systemVersion
    }()

    static var TheCurrentDeviceHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.main.bounds.size.height
        }
        return Singleton.height
    }

    // MARK: - Device Idiom Checks
    static var PHONE_OR_PAD: String {
        if isPhone() {
            return "iPhone"
        } else if isPad() {
            return "iPad"
        }
        return "Not iPhone nor iPad"
    }

    static var DEBUG_OR_RELEASE: String {
        #if DEBUG
        return "Debug"
        #else
        return "Release"
        #endif
    }

    static var SIMULATOR_OR_DEVICE: String {
        #if targetEnvironment(simulator)
        return "Simulator"
        #else
        return "Device"
        #endif
    }

    static let AppVersion: String = {
        let nsObject: AnyObject? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as AnyObject
        //Then just cast the object as a String, but be careful, you may want to double check for nil
        let version = nsObject as? String ?? ""
        return version
    }()

    static func isPhone() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .phone
    }

    static func isPad() -> Bool {
        return TheCurrentDevice.userInterfaceIdiom == .pad
    }

    static func isDebug() -> Bool {
        return DEBUG_OR_RELEASE == "Debug"
    }

    static func isRelease() -> Bool {
        return DEBUG_OR_RELEASE == "Release"
    }

    static func isSimulator() -> Bool {
        return SIMULATOR_OR_DEVICE == "Simulator"
    }

    static func isDevice() -> Bool {
        return SIMULATOR_OR_DEVICE == "Device"
    }

    // MARK: - Device Version Checks
    enum Versions: Float {
        case Ten = 10.0
        case Eleven = 11.0
        case Twelve = 12.0
    }

    static func isVersion(version: Versions) -> Bool {
        return Float(TheCurrentDeviceVersion) >= version.rawValue && TheCurrentDeviceVersion < (version.rawValue + 1.0)
    }

    static func isVersionOrLater(version: Versions) -> Bool {
        return TheCurrentDeviceVersion >= version.rawValue
    }

    static func isVersionOrEarlier(version: Versions) -> Bool {
        return TheCurrentDeviceVersion < (version.rawValue + 1.0)
    }

    static var CURRENT_VERSION: String {
        return "\(TheCurrentDeviceVersion)"
    }

    // MARK: iOS 10 Checks
    static func IS_OS_10() -> Bool {
        return isVersion(version: Versions.Ten)
    }

    static func IS_OS_10_OR_LATER() -> Bool {
        return isVersionOrLater(version: Versions.Ten)
    }

    static func IS_OS_10_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(version: Versions.Ten)
    }

    // MARK: iOS 11 Checks
    static func IS_OS_11() -> Bool {
        return isVersion(version: Versions.Eleven)
    }

    static func IS_OS_11_OR_LATER() -> Bool {
        return isVersionOrLater(version: Versions.Eleven)
    }

    static func IS_OS_11_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(version: Versions.Eleven)
    }
    // MARK: iOS 12 Checks
    static func IS_OS_12() -> Bool {
        return isVersion(version: Versions.Twelve)
    }

    static func IS_OS_12_OR_LATER() -> Bool {
        return isVersionOrLater(version: Versions.Twelve)
    }

    static func IS_OS_13_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(version: Versions.Twelve)
    }

    // MARK: - Device Size Checks
    enum Heights: CGFloat {
        case Inches_4 = 568
        case Inches_4_7 = 667
        case Inches_5_5 = 736
    }

    static func isSize(height: Heights) -> Bool {
        return TheCurrentDeviceHeight == height.rawValue
    }

    static func isSizeOrLarger(height: Heights) -> Bool {
        return TheCurrentDeviceHeight >= height.rawValue
    }

    static func isSizeOrSmaller(height: Heights) -> Bool {
        return TheCurrentDeviceHeight <= height.rawValue
    }

    static var CURRENT_SIZE: String {
        if IS_4_INCHES() {
            return "4 Inches"
        } else if IS_4_7_INCHES() {
            return "4.7 Inches"
        } else if IS_5_5_INCHES() {
            return "5.5 Inches"
        }
        return "\(TheCurrentDeviceHeight) Points"
    }

    // MARK: 4 Inch Checks
    static func IS_4_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_4)
    }

    static func IS_4_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_4)
    }

    static func IS_4_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(height: .Inches_4)
    }

    // MARK: 4.7 Inch Checks
    static func IS_4_7_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_4_7)
    }

    static func IS_4_7_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_4_7)
    }

    static func IS_4_7_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_4_7)
    }

    // MARK: 5.5 Inch Checks
    static func IS_5_5_INCHES() -> Bool {
        return isPhone() && isSize(height: .Inches_5_5)
    }

    static func IS_5_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_5_5)
    }

    static func IS_5_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(height: .Inches_5_5)
    }

    // MARK: - International Checks
    static var CURRENT_REGION: String? {
        return Locale.current.languageCode
    }
}
