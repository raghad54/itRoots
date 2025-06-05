//
//  String+Localization..swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 03/06/2025.
//

import Foundation


extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
