import UIKit

struct ProfileTableHeaderViewModel {
    let avatarImage: UIImage?
    let fullNameLabel: String
    let statusLabel: String
    let statusPlaceholder: String
    let statusText: String

    init() {
        self.avatarImage = #imageLiteral(resourceName: "4")
        self.fullNameLabel = "My name"
        self.statusLabel = "My status"
        self.statusPlaceholder = "Set your status"
        self.statusText = ""
    }
}

