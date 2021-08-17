//
//  LocalEpaper+Helper.swift
//  LocalEpaper+Helper
//
//  Created by Accounting on 12/08/21.
//

import Foundation
import CoreData

extension LocalEpaper {
    convenience init(path: String, name: String, context : NSManagedObjectContext){
        self.init(context: context)
        self.name = name
        self.path = path
    }
    
    static func fetch() -> NSFetchRequest<LocalEpaper> {
        let request = NSFetchRequest<LocalEpaper>(entityName: "LocalEpaper")
        request.sortDescriptors = []
        return request
    }
}
