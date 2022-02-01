import Foundation

enum ProfileFlowLocalization {
    case timerLabel
    case seconds
    case photosCellTitle
    case setStatusButton, logOutButton
    case fullName, status, statusPlaceholder
    
    var localizedValue: String {
        switch  self {
        case .timerLabel:
            return NSLocalizedString("timerLabel", comment: "timerLabel title")
        case .seconds:
            return NSLocalizedString("seconds", comment: "seconds title")
        case .photosCellTitle:
            return NSLocalizedString("photosCellTitle", comment: "photosCell title")
        case .setStatusButton:
            return NSLocalizedString("setStatusButton", comment: "setStatusButton title")
        case .logOutButton:
            return NSLocalizedString("logOutButton", comment: "logOutButton title")
        case .fullName:
            return NSLocalizedString("fullName", comment: "fullName title")
        case .status:
            return NSLocalizedString("status", comment: "status title")
        case .statusPlaceholder:
            return NSLocalizedString("statusPlaceholder", comment: "statusPlaceholder title")
        }
    }
}

enum FavoriteFlowLocalization {
    case deleteFavoriteItem
    
    var localizedValue: String {
        switch self {
        case .deleteFavoriteItem:
            return NSLocalizedString("deleteFavoriteItem", comment: "delete favorite item")
        }
    }
}

enum AlertLocalization {
    case infoAlertTitle, infoMessageTitle
    case cancelActionTitle, deleteActionTitle, saveActionTitle
    case favoriteAlertTitle, favoriteMessageTitle, favoriteAlertPlaceholder
    case profileAlertTitle
    
    var localizedValue: String {
        switch  self {
        case .infoAlertTitle:
            return NSLocalizedString("infoAlertTitle", comment: "infoAlert title")
        case .infoMessageTitle:
            return NSLocalizedString("infoMessageTitle", comment: "infoMessage title")
        case .cancelActionTitle:
            return NSLocalizedString("cancelActionTitle", comment: "cancelAction title")
        case .deleteActionTitle:
            return NSLocalizedString("deleteActionTitle", comment: "deleteAction title")
        case .saveActionTitle:
            return NSLocalizedString("saveActionTitle", comment: "saveAction title")
        case .favoriteAlertTitle:
            return NSLocalizedString("favoriteAlertTitle", comment: "favoriteAlert title")
        case .favoriteMessageTitle:
            return NSLocalizedString("favoriteMessageTitle", comment: "favoriteMessage title")
        case .favoriteAlertPlaceholder:
            return NSLocalizedString("favoriteAlertPlaceholder", comment: "favoriteAlertPlaceholder title")
        case .profileAlertTitle:
            return NSLocalizedString("profileAlertTitle", comment: "profileAlert title")
        }
    }
}

enum ApiErrorLocalization {
    case dataNotFoundTitle, dataNotFoundMessage
    case networkConnectionProblemTitle, networkConnectionProblemMessage
    
    var localizedValue: String {
        switch  self {
        case .dataNotFoundTitle:
            return NSLocalizedString("dataNotFoundTitle", comment: "dataNotFound title")
        case .dataNotFoundMessage:
            return NSLocalizedString("dataNotFoundMessage", comment: "dataNotFound message")
        case .networkConnectionProblemTitle:
            return NSLocalizedString("networkConnectionProblemTitle", comment: "networkConnectionProblem title")
        case .networkConnectionProblemMessage:
            return NSLocalizedString("networkConnectionProblemMessage", comment: "networkConnectionProblem message")
        }
    }
}

enum PhotosFlowLocalization {
    case photosTitle
    
    var localizedValue: String {
        switch  self {
        case .photosTitle:
            return NSLocalizedString("photosTitle", comment: "photos title")
        }
    }
}

enum LoginFlowLocalization {
    case loginPlaceholder, passwordPlaceholder
    case loginButtonTitle
    
    var localizedValue: String {
        switch self {
        case .loginPlaceholder:
            return NSLocalizedString("loginPlaceholder", comment: "loginPlaceholder title")
        case .passwordPlaceholder:
            return NSLocalizedString("passwordPlaceholder", comment: "passwordPlaceholder title")
        case .loginButtonTitle:
            return NSLocalizedString("loginButton", comment: "firstPostButton loginButton title")
        }
    }
}

enum FeedFlowLocalization {
    case hideTitle
    case addTitle
    case mainLabel
    
    var localizedValue: String {
        switch  self {
        case .hideTitle:
            return NSLocalizedString("hideTitle", comment: "hide title")
        case .addTitle:
            return NSLocalizedString("addTitle", comment: "add title")
        case .mainLabel:
            return NSLocalizedString("mainLabel", comment: "main label")
        }
    }
}

enum TabBarLocalization {
    case favorite, feed, profile
    
    var localizedValue: String {
        switch  self {
        
        case .favorite:
            return NSLocalizedString("favorite", comment: "favorite tab bar")
        case .feed:
            return NSLocalizedString("feed", comment: "feed tab bar")
        case .profile:
            return NSLocalizedString("profile", comment: "profile tab bar")
        }
    }
}


