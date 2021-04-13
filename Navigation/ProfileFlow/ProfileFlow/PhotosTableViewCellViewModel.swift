
import UIKit
import iOSIntPackage

struct PhotosTableViewCellViewModel {
    
    private var imageProcessor = ImageProcessor()
    
    let titleLabel: String
    let arrowLabel: String
    let firstImage: UIImage?
    let secondImage: UIImage?
    let thirdImage: UIImage?
    let fourthImage: UIImage?
    
    init() {
        self.titleLabel = "Photos"
        self.arrowLabel = "->"
        self.firstImage = UIImage(named: "5")
        self.secondImage = UIImage(named: "6")
        self.thirdImage = UIImage(named: "7")
        self.fourthImage = UIImage(named: "8")
        
    }
    
    func useChromeFilter(image: UIImage, completion: (UIImage?) -> Void) {
        imageProcessor.processImage(sourceImage: image,
                                    filter: .chrome,
                                    completion: completion)
    }
    
    func useColorInvertFilter(image: UIImage, completion: (UIImage?) -> Void) {
        imageProcessor.processImage(sourceImage: image,
                                    filter: .colorInvert,
                                    completion: completion)
    }
    
    func useFadeFilter(image: UIImage, completion: (UIImage?) -> Void) {
        imageProcessor.processImage(sourceImage: image,
                                    filter: .fade,
                                    completion: completion)
    }
    
    func useNoirFilter(image: UIImage, completion: (UIImage?) -> Void) {
        imageProcessor.processImage(sourceImage: image,
                                    filter: .noir,
                                    completion: completion)
    }
    
}
