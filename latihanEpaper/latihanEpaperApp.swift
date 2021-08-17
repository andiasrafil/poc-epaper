//
//  latihanEpaperApp.swift
//  latihanEpaper
//
//  Created by Accounting on 04/08/21.
//

import SwiftUI
import PSPDFKit

@main
struct latihanEpaperApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene{
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
//    init() {
//        SDK.setLicenseKey("xEhEdERbV7SDLOcWvWAwIZ4rGO9uoEdwPHKvNG-1zaVPPBv6gNaLlyz7YijqkPsHrH1jQlEJ-0pACbYEp2bB1THblhGcDdGPoBdamhFAKzRN0_BXTA1bzMij0uf-pDOzXz48UrObITkRjzQ0Dl9nzWs-hQ1CcADTY-SXtfhxqLJiFRVtSgCdyyh_h389p1K52uYE2PGVxkU25U1HWpyP8O7JbB9bcNQ_3Wn9yaq4rkzYhISrh-z80YKhQymPK6Fy6q4G3XQY7hgucZK_6HHNDan8yxIWi8ELxzJ9Zmg8nJIO7pbiYL8QmypCdNCLUyhawNmwu7kPAL_BSRYL1WF3QhKKXlqZRMGCbotInJf8LH9Qrd5j2pjVoPJiBtKuBidRG7a8ePZINDnA-mkvjIbfJmW5_Si48-5VhWxTtOEHL60NgEPAzzUe3Qto88rSF5jrcDrStsAHTUyVjbwdq4VHmFyBOKYSUcBBloD-NwisTJdQnwt0SIfBeLkexOdEH9iyf4GVNAyC231GvXGjwfYdBRwVPHeXT1YKIlMPxE2T64M9-cNF0nk6wHRc74o1sGb8ylZNOkqKn3bnhkSI0TLN_g==")
//    }
}
