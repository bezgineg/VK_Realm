import Foundation

struct FavoritePostTableViewCellViewModel {
    let author: String
    let description: String
    let image: String
    let likes: Int64
    let view: Int64
    
    init(with model: FavoritePost) {
        self.author = model.author ?? ""
        self.description = model.descript ?? ""
        self.image = model.image ?? ""
        self.likes = model.likes
        self.view = model.views
    }
}
