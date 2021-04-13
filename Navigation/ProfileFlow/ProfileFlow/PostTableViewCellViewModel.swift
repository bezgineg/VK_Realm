
import Foundation

enum ApiError: Error {
    case dataNotFound
    case networkConnectionProblem
}

struct PostTableViewCellViewModel {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let view: Int
    
    init(with model: Post) {
        self.author = model.author
        self.description = model.description
        self.image = model.image
        self.likes = model.likes
        self.view = model.view
    }
}
