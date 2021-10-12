import UIKit
import Kingfisher
import Accelerate

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let api = API()
    var gallary : [Datum] = []

    var isLoading = false
    var pageLoaded = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setUpBackgroundView()
        
        getGallery(page: pageLoaded)
    }
    
    private func setUpBackgroundView() {
        collectionView.backgroundView = {
            let imageView = UIImageView(image: UIImage(named: "eWtfMME"))
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
    }
    
    func getGallery(page: Int) {
        api.getImages(page: page) { [weak self] gallary in
            guard let data = gallary?.data.prefix(20) else {
                return
            }
            self?.gallary += data
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.isLoading = false
        }
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isLoading {
            let pos = scrollView.contentOffset.y
            if pos > (collectionView.contentSize.height - 100 - scrollView.frame.size.height) {
                isLoading = true
                self.pageLoaded += 1
                self.getGallery(page: pageLoaded)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                print(gallary.count)
            }
        }
    }
}

