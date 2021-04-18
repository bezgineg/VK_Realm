//
//  FavoritePost+CoreDataProperties.swift
//  Navigation
//
//  Created by Побегуц Ольга on 18.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoritePost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePost> {
        return NSFetchRequest<FavoritePost>(entityName: "FavoritePost")
    }

    @NSManaged public var author: String?
    @NSManaged public var descript: String?
    @NSManaged public var image: String?
    @NSManaged public var views: Int64
    @NSManaged public var likes: Int64

}
