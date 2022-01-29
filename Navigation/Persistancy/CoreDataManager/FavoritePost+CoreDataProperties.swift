

import Foundation
import CoreData
import UIKit


extension FavoritePost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePost> {
        return NSFetchRequest<FavoritePost>(entityName: "FavoritePost")
    }

    @NSManaged public var author: String?
    @NSManaged public var descript: String?
    @NSManaged public var image: Data?
    @NSManaged public var views: Int64
    @NSManaged public var likes: Int64

}
