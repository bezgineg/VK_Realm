import UIKit

struct ProfileTableHeaderViewModel {
    let avatarImage: UIImage?
    let fullNameLabel: String
    let statusLabel: String
    let statusPlaceholder: String
    let statusText: String

    init() {
        self.avatarImage = #imageLiteral(resourceName: "4")
        self.fullNameLabel = ProfileFlowLocalization.fullName.localizedValue
        self.statusLabel = ProfileFlowLocalization.status.localizedValue
        self.statusPlaceholder = ProfileFlowLocalization.statusPlaceholder.localizedValue
        self.statusText = ""
    }
}

