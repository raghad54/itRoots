//
//  LocalizedBundle.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 05/06/2025.
//

import Foundation

import UIKit
import Foundation
import ObjectiveC

private var bundleKey: UInt8 = 0

extension Bundle {
    class func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, PrivateBundle.self)
        }

        let languageBundlePath = Bundle.main.path(forResource: language, ofType: "lproj")
        let languageBundle = languageBundlePath != nil ? Bundle(path: languageBundlePath!) : nil
        objc_setAssociatedObject(Bundle.main, &bundleKey, languageBundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    private class PrivateBundle: Bundle {
        override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
            let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle
            return bundle?.localizedString(forKey: key, value: value, table: tableName) ?? super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}

