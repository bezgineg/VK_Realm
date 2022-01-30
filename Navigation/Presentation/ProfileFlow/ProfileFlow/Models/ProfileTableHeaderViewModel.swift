import UIKit

struct ProfileTableHeaderViewModel {
    
    // MARK: - Public Properties
    
    public let avatarImage: UIImage?
    public let fullNameLabel: String
    public let statusLabel: String
    public let statusPlaceholder: String
    public let statusText: String

    // MARK: - Initializers
    
    init() {
        self.avatarImage = #imageLiteral(resourceName: "4")
        self.fullNameLabel = ProfileFlowLocalization.fullName.localizedValue
        self.statusLabel = ProfileFlowLocalization.status.localizedValue
        self.statusPlaceholder = ProfileFlowLocalization.statusPlaceholder.localizedValue
        self.statusText = ""
    }
}

