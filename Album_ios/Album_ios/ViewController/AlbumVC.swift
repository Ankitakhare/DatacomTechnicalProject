import UIKit

class AlbumVC: UIViewController {
    
    var viewModel = AlbumViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album List"
        setupView()
        callWebserviceForAlbumsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupView(){
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    private func callWebserviceForAlbumsList(){
        viewModel.fetchUserDetail()
        viewModel.reloadTableView = { error in
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
}


//MARK:- Table View Methods

extension AlbumVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.AlbumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let albumCell = tableView.dequeueReusableCell(withIdentifier: "AlbumTitleCell", for: indexPath) as? AlbumTitleCell {
            let album = self.viewModel.AlbumList[indexPath.row]
            albumCell.titleLabel.text = album.title.capitalized
            albumCell.userLabel.text = "By \(self.viewModel.getUserName(for: album.userId))"
            cell = albumCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlbumDetailVC") as! AlbumDetailVC
        vc.albumId = self.viewModel.AlbumList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
}

