import UIKit
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let api = API()
    var gallary : [Datum] = []
    var loadCount = 100
    var pageLoaded = 1
    let cellID = "cell"
    private var isLoading = false
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    private let itemsPerRow: CGFloat = 2
    
    private let placeHolderImage = UIImage(named: "placeholder-image")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "eWtfMME"))
        
        getGallery(page: pageLoaded)
    }
    
    fileprivate func getGallery(page: Int) {
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CollectionViewCell
        if gallary.isEmpty {
            return cell
        }
        
        if let imageUrlString = gallary[indexPath.row].images?[0].link {
            cell.cellImageView.kf.setImage(with: URL(string: imageUrlString), placeholder: placeHolderImage)
        } else {
            cell.cellImageView.image = placeHolderImage
        }
        
        cell.cellLabel.text = gallary[indexPath.row].title

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "detailVC") as! DetailViewController
        vc.id = gallary[indexPath.row].id
        vc.imageURL = gallary[indexPath.row].images?[0].link
        present(vc, animated: true, completion: nil)
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
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
