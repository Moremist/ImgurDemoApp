import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailTableView: UITableView!
    
    var id: String?
    var imageURL: String?
    let api = API()
    var commentList: CommentsList?
    let cellIdentifier = "detailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.rowHeight = UITableView.automaticDimension
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "eWtfMME"))
        
        getComments()
        setImage()
    }
    
    fileprivate func getComments() {
        if let id = id {
            api.getCommentsFor(galleryHash: id) { [weak self] list in
                self?.commentList = list
                DispatchQueue.main.async {
                    self?.detailTableView.reloadData()
                }
            }
        }
    }
    
    fileprivate func setImage() {
        if let imageURL = imageURL {
            imageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "placeholder-image"))
        } else {
            imageView.image = UIImage(named: "placeholder-image")
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomTableViewCell
        cell.commentLabel.text = commentList?.data[indexPath.row].comment
        cell.authorLabel.text = commentList?.data[indexPath.row].author
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.detailTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
