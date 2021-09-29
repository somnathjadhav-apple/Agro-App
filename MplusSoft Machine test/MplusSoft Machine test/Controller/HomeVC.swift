//
//  HomeVC.swift
//  MplusSoft Machine test
//
//  Created by Somnath on 25/09/21.
//

import UIKit

//MARK:- URLs
let urlString = "http://www.agropost.in/admin/android/get-product-category"
let getPostUrlString = "http://www.agropost.in/admin/android/get-post-list"
let baseURLString = "https://agropost.in/admin/"

class HomeVC: UIViewController {
    
    
    var category = [ProductCategoryList]()
    var productList: PostGetPostList?

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchTextField?.backgroundColor = UIColor(red: 200.0/255, green: 200.0/255, blue: 200.0/255, alpha: 1.0)

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()

        searchBar.backgroundImage = UIImage()

        getProductCategoryList()
    }
    
    //MARK:- NetWork Calls
    
    func getProductCategoryList() {
        NetworkManager().GETServices(url: urlString, completionHandler: {(productCategory) in
            self.category = productCategory
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            if self.category.count > 0 {
                let prodCat = self.category[0]
                self.getPostList(prodCat.pkID)
            }
           print(productCategory)
        })
    }
    
    func getPostList(_ productCategory: String) {
        

        let dataString = "distance=201&offset=0&user_id=6069&post_name=&ad_offset=0&ad_category=&limit=10&send_ad=yes&used_new_type=&product_category_id=\(productCategory)"

        NetworkManager().POSTService(url: getPostUrlString, postString: dataString, completionHandler: { (postList) in
            print("Post List: \(postList)")
            self.productList = postList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    //MARK:- Button Actions
    
    @IBAction func menuBarButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Button Action is not decided yet ! ⚠️", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    @IBAction func alertBarButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Button Action is not decided yet ! ⚠️", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    @IBAction func filterBarButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Button Action is not decided yet ! ⚠️", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}

//MARK:- Collection view Delegate and Data source Methods

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        let categoryIndex = category[indexPath.row]
        categoryCell.categoryLbl.text = categoryIndex.categoryNameEnglish

        let imgURL = URL.init(string: baseURLString.appending(categoryIndex.activeCategoryIconThumbPath) )
        let imageData = try? Data.init(contentsOf: imgURL!)
        categoryCell.imgView.image = UIImage.init(data: imageData!)
    
        return categoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let prodCat = self.category[indexPath.row]
        self.getPostList(prodCat.pkID)
    }
}

//MARK:- Table view Delegate and Data source Methods

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList?.postList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productListCell = self.tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as? ProductListTableViewCell
        
        let productIndex = productList?.postList[indexPath.row]
        
        productListCell?.nameLbl.text = productIndex?.postName
        productListCell?.farmLbl.text = productIndex?.postBy
        productListCell?.addressLbl.text = productIndex?.location
        productListCell?.priceLbl.text = productIndex?.price ?? "0"
        
        let imgURL = URL.init(string: baseURLString.appending(productIndex!.postImg1Path) )
        let imageData = try? Data.init(contentsOf: imgURL!)
        productListCell?.productImage.image = UIImage.init(data: imageData!)
        
        return productListCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
