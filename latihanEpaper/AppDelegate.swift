//
//  AppDelegate.swift
//  latihanEpaper
//
//  Created by Accounting on 05/08/21.
//

import Foundation
import UIKit
import OSLog
import PSPDFKit
import PSPDFKitUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        os_log("handleEventsForBackgroundURLSession for %@", type: .info, identifier)
        completionHandler()
    }
    
    private func customizeAppearanceOfNavigationBar() {
        // Use dynamic colors for light mode and dark mode for iOS 13 and above.
        let backgroundColor = UIColor {
            $0.userInterfaceStyle == .dark ? UIColor(white: 0.2, alpha: 1) : UIColor(red: 1, green: 0.72, blue: 0.3, alpha: 1)
        }
        let foregroundColor = UIColor {
            $0.userInterfaceStyle == .dark ? UIColor(red: 1, green: 0.8, blue: 0.5, alpha: 1) : UIColor(white: 0, alpha: 1)
        }

        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]
        appearance.backgroundColor = backgroundColor

        let appearanceProxy = UINavigationBar.appearance(whenContainedInInstancesOf: [PDFNavigationController.self])
        appearanceProxy.standardAppearance = appearance
        appearanceProxy.compactAppearance = appearance
        appearanceProxy.scrollEdgeAppearance = appearance
        appearanceProxy.tintColor = foregroundColor

        // Repeat the same customization steps for
        // [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[PSPDFNavigationController.class, UIPopoverPresentationController.class]];
        // if you want to customize the look of navigation bars in popovers on iPad as well.
    }

    private func customizeAppearanceOfToolbar() {
        // Use dynamic colors for light mode and dark mode for iOS 13 and above.
        let backgroundColor = UIColor {
            $0.userInterfaceStyle == .dark ? UIColor(white: 0.2, alpha: 1) : UIColor(red: 0.77, green: 0.88, blue: 0.65, alpha: 1)
        }
        let foregroundColor = UIColor {
            $0.userInterfaceStyle == .dark ? UIColor(red: 0.86, green: 0.93, blue: 0.78, alpha: 1) : UIColor(white: 0, alpha: 1)
        }

        let appearance = UIToolbarAppearance()
        appearance.backgroundColor = backgroundColor

        let appearanceProxy = FlexibleToolbar.appearance()
        appearanceProxy.standardAppearance = appearance
        appearanceProxy.compactAppearance = appearance
        appearanceProxy.tintColor = foregroundColor
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        customizeAppearanceOfToolbar()
        customizeAppearanceOfNavigationBar()
//        SDK.setLicenseKey("xEhEdERbV7SDLOcWvWAwIZ4rGO9uoEdwPHKvNG-1zaVPPBv6gNaLlyz7YijqkPsHrH1jQlEJ-0pACbYEp2bB1THblhGcDdGPoBdamhFAKzRN0_BXTA1bzMij0uf-pDOzXz48UrObITkRjzQ0Dl9nzWs-hQ1CcADTY-SXtfhxqLJiFRVtSgCdyyh_h389p1K52uYE2PGVxkU25U1HWpyP8O7JbB9bcNQ_3Wn9yaq4rkzYhISrh-z80YKhQymPK6Fy6q4G3XQY7hgucZK_6HHNDan8yxIWi8ELxzJ9Zmg8nJIO7pbiYL8QmypCdNCLUyhawNmwu7kPAL_BSRYL1WF3QhKKXlqZRMGCbotInJf8LH9Qrd5j2pjVoPJiBtKuBidRG7a8ePZINDnA-mkvjIbfJmW5_Si48-5VhWxTtOEHL60NgEPAzzUe3Qto88rSF5jrcDrStsAHTUyVjbwdq4VHmFyBOKYSUcBBloD-NwisTJdQnwt0SIfBeLkexOdEH9iyf4GVNAyC231GvXGjwfYdBRwVPHeXT1YKIlMPxE2T64M9-cNF0nk6wHRc74o1sGb8ylZNOkqKn3bnhkSI0TLN_g==")
        
        return true
    }
}
