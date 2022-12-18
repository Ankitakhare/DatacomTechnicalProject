
import UIKit

class AlbumImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imgAlbum: UIImageView!
    var albumImage: AlbumImageModel?{
        didSet{
            self.setUpUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgAlbum.layer.cornerRadius = self.imgAlbum.frame.size.height/2
        self.imgAlbum.layer.masksToBounds = true
    }
    
    private func setUpUI(){
        
        if let url = URL(string: albumImage?.thumbnailUrl ?? ""){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.imgAlbum.image = UIImage(data: data)
                    }
                }else{
                    self.imgAlbum.image = UIImage(named: "img")
                }
            }
        }
    }
}


