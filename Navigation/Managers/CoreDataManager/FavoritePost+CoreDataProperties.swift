

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
