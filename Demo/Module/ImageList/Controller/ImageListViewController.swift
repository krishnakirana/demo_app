/*
 * Name of the module - Demo
 * Created date - 17/04/21
 * Created by - Krishna Kirana
 * Synopsis - View controller for displaying the image list
 */

import UIKit
import Lightbox

class ImageListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    var viewModel: ImageListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ImageListViewModel(delegate: self)
        self.setupTableView()
        self.viewModel.getGallaryDetails()
    }
}

//MARK:- Supporting Methods
extension ImageListViewController {
    private func setupTableView() {
        self.tableView.register(UINib.init(nibName: "ImageListTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageListTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Pull to refresh feature
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

    }
    
    @objc private func refreshData(_ sender: Any) {
        self.viewModel.getGallaryDetails()
    }
}

extension ImageListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.movieDetailsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let movieDetails = self.viewModel.movieDetailsList?[indexPath.row],
           let cellDetails = tableView.dequeueReusableCell(withIdentifier: "ImageListTableViewCell") as? ImageListTableViewCell {
            cellDetails.tableView = self.tableView
            cellDetails.movieDetails = movieDetails
            return cellDetails
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let photoDetails = self.viewModel.movieDetailsList?[indexPath.row], let url = URL(string: photoDetails.generatePosterPathUrl()) {
        let images = [
            LightboxImage(imageURL: url, text: photoDetails.title ?? "")
        ]
            
        let controller = LightboxController(images: images)
        controller.dynamicBackground = true
        present(controller, animated: true, completion: nil)
        }
    }
}

//MARK:- Image List Protocol Methods
extension ImageListViewController: ImageListProtocol {
    
    /**
     Gallary details updated callback
     */
    func gallaryDetailsUpdated() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            if nil != self.viewModel.movieDetailsList {
                self.tableView.reloadData()
            } else {
                let errorDialog =  UIAlertController.init(title: "Something went wrong", message: "Please try again later", preferredStyle: .alert)
                errorDialog.addAction(UIAlertAction.init(title: "Retry", style: .default, handler: { [weak self] (_) in
                    self?.viewModel.getGallaryDetails()
                }))
                
                errorDialog.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (_) in
                    
                }))
                
                self.present(errorDialog, animated: true, completion: nil)
            }
        }
    }
}

extension ImageListViewController {
    
    /**
     Screen rotation callback
     */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.tableView.reloadData()
    }
}

