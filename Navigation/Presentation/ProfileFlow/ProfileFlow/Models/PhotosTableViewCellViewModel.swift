
import UIKit
import iOSIntPackage

struct PhotosTableViewCellViewModel {
    
    // MARK: - Private Properties
    
    private var imageProcessor = ImageProcessor()
    
    // MARK: - Public Properties
    
    public let titleLabel: String
    public let arrowLabel: String
    public let firstImage: UIImage?
    public let secondImage: UIImage?
    public let thirdImage: UIImage?
    public let fourthImage: UIImage?
    
    // MARK: - Initializers
    
    init() {
        self.titleLabel = ProfileFlowLocalization.photosCellTitle.localizedValue
        self.arrowLabel = "->"
        self.firstImage = UIImage(named: "5")
        self.secondImage = UIImage(named: "6")
        self.thirdImage = UIImage(named: "7")
        self.fourthImage = UIImage(named: "8")
    }
    
    // MARK: - Public Methods
    
    public func useChromeFilter(image: UIImage, completion: (UIImage?) -> Void) {
        imageProcessor.processImage(sourceImage: image, filter: .chrome, completion: completion)
    }
    
    public func useColorInvertFilter(image: UIImage, completion: (UIImage?) -> Void) {
        imageProcessor.processImage(sourceImage: image, filter: .colorInvert, completion: completion)
    }
    
    public func useFadeFilter(image: UIImage, completion: (UIImage?) -> Void) {
        imageProcessor.processImage(sourceImage: image, filter: .fade, completion: completion)
    }
    
    public func useNoirFilter(image: UIImage, completion: (UIImage?) -> Void) {
        imageProcessor.processImage(sourceImage: image, filter: .noir, completion: completion)
    }
}
