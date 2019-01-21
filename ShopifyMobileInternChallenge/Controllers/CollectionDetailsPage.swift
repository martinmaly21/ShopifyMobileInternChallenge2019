//
//  CollectionDetailsPage.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-20.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

class CollectionDetailsPage: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    var collectionTitle: String?
    var collectionDescription: String?
    var collectionImageString: String?
    //might have to make this lazy depending on what happens
    var collectionID: Int?
    
    var products: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        layout.scrollDirection = .vertical
        collectionView.isScrollEnabled = true
        setUpCollectionView()
        loadCollectJson(self.collectionID!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return actual count in due time
        return products.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as! DynamicCard
            cell1.cardTitle.text = self.collectionTitle
            cell1.cardDescription.text = self.collectionDescription
            let imageURL = self.collectionImageString
            
            let url = URL(string: imageURL!)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    //alert user
                    print(error!)
                    return
                } else {
                    DispatchQueue.main.async {
                        cell1.cardImageView.image = UIImage(data: data!)
                        cell1.cardImageView.image = cell1.cardImageView.image?.alpha(0.4)
                    }
                }
                }.resume()
            
            return cell1
        } else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! CollectionDetailCell
            cell2.product = products[indexPath.item - 1]
            return cell2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthOfCell = ( collectionView.frame.width / 2 ) - 15
        let heightOfCell = widthOfCell + 100
        
        if indexPath.item == 0 {
            widthOfCell = widthOfCell * 2 + 10
            //TODO: Explain why i thought dynamic resizing was unnecessary
        }
        let sizeOfCell = CGSize(width: widthOfCell, height: heightOfCell)
        return sizeOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    private func setUpCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.register(DynamicCard.self, forCellWithReuseIdentifier: "Cell1")
        collectionView.register(CollectionDetailCell.self, forCellWithReuseIdentifier: "Cell2")
        collectionView.backgroundColor = UIColor.rgb(red: 92, green: 106, blue: 196)
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(title)
        title.leftAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
        title.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: -40).isActive = true
        title.text = "Your Products"
        title.textColor = UIColor.white
        let fontDescriptor = UIFontDescriptor(name: "HelveticaNeue-Bold", size: 0)
        title.font = UIFont(descriptor: fontDescriptor, size: 25)
        //        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    private func getProductURL(_ integerArray: [Int]) -> String {
        var cancatenatedString = ""
        for number in integerArray {
            cancatenatedString += "\(number),"
        }
        cancatenatedString.removeLast()
        let url = "https://shopicruit.myshopify.com/admin/products.json?ids=\(cancatenatedString)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        return url
    }
    
    private func loadCollectJson(_ collectionID: Int) {
        let collectionJsonURL = "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\(collectionID)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        guard let url = URL(string: collectionJsonURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                //alert user
                print(error!)
                return
            } else {
                guard let data = data else { return }
                do {
                    let collectionArray = try JSONDecoder().decode(CollectArray.self, from: data)
                    var tempArray: [Int] = []
                    for collect in collectionArray.collects {
                        tempArray.append(collect.product_id!)
                    }
                    DispatchQueue.main.async {
                        let productJsonUrl = self.getProductURL(tempArray)
                        guard let url = URL(string: productJsonUrl) else { return }
                        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                            if error != nil {
                                //alert user
                                print(error!)
                            } else {
                                guard let data = data else { return }
                                do {
                                    let productArray = try JSONDecoder().decode(ProductArray.self, from: data)
                                    self.products = [Product]()
                                    
                                    for product in productArray.products! {
                                        var productCell = Product()
                                        productCell.title = product.title
                                        productCell.vendor = product.vendor
                                        productCell.image = product.image
                                        productCell.variants = product.variants

                                        self.products.append(productCell)
                                    }
                                    DispatchQueue.main.async {
                                        self.collectionView.reloadData()
                                    }
                                } catch let jsonErr {
                                    //change alert message?
                                    print(jsonErr)
                                }
                            }
                        }).resume()
                    }
                } catch let jsonErr {
                    //change alert message?
                    print(jsonErr)
                }
            }
            }.resume()
    }
}
