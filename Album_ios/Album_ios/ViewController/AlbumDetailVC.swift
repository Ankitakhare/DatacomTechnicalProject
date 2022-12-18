
import UIKit

class AlbumDetailVC: UIViewController {
    
    var albumViewModelObj = AlbumViewModel()
    var albumId: Int = 0
    
    // @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewFull: UIView!
    @IBOutlet weak var imgFull: UIImageView!
    @IBOutlet weak var collectionViewAlbums: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album Image"
        self.viewFull.isHidden = true
        
        self.callWebserviceForAlbumsImageList()
    }
    
    private  func callWebserviceForAlbumsImageList(){
        let activityIndiactor = UIActivityIndicatorView(style: .large)
        self.view.addSubview(activityIndiactor)
        activityIndiactor.center = self.view.center
        activityIndiactor.startAnimating()
        albumViewModelObj.fetchPhotos(albumId: self.albumId)
        albumViewModelObj.reloadTableView = { error in
            DispatchQueue.main.async {
                activityIndiactor.stopAnimating()
                activityIndiactor.removeFromSuperview()
                self.collectionViewAlbums.reloadData()
                
            }
            
        }
        
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.title = "Album Image"
        self.viewFull.isHidden = true
    }
}

//MARK:- Collection View Methods
extension AlbumDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albumViewModelObj.arrayImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "AlbumImageCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AlbumImageCell
        
        let obj = self.albumViewModelObj.arrayImageList[indexPath.row]
        cell.albumImage = obj
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let obj = self.albumViewModelObj.arrayImageList[indexPath.row]
        
        self.imgFull.image = nil
        
        if let url = URL(string: obj.url ){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.imgFull.image = UIImage(data: data)
                    }
                }else{
                    self.imgFull.image = UIImage(named: "img")
                }
            }
        }
        
        self.viewFull.isHidden = false
        self.title = "Thumbnail"
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = CGFloat((self.collectionViewAlbums.frame.size.width - 10) / 2)
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
}
