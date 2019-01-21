//
//  ViewController.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-18.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var collections: [Collection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        collectionViewSetup()
        loadCollectionJson()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionCell
        if let collect = collections {
            cell.collection = collect[indexPath.item]
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //code to run when an item in the collection view is selected
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
        let destVC = CollectionDetailsPage()
        destVC.collectionTitle = cell.collection?.title
        destVC.collectionDescription = cell.collection?.body_html
        destVC.collectionImageString = cell.collection?.image?.src
        destVC.collectionID = cell.collection?.id
        self.navigationController?.pushViewController(destVC, animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //note that each image is 300x300, which allows for consistent sizing of collection view cells
        //the remaining fifty pixels will be used for the label (and maybe description)
        let widthOfCell = ( collectionView.frame.width / 2 ) - 15
        let heightOfCell = widthOfCell + 30
        let sizeOfCell = CGSize(width: widthOfCell, height: heightOfCell)
        return sizeOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    private func customizeNavBar() {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo.png")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        if let nav = navigationController {
            nav.navigationBar.addSubview(logoImageView)
            logoImageView.leftAnchor.constraint(equalTo: nav.navigationBar.leftAnchor, constant: 10).isActive = true
            logoImageView.bottomAnchor.constraint(equalTo: nav.navigationBar.bottomAnchor, constant: -8).isActive = true
            
            //logo has an aspect ratio of 1000 : 286, so I'll use that ratio
            logoImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
            logoImageView.heightAnchor.constraint(equalToConstant: 45.76).isActive = true
            nav.navigationBar.prefersLargeTitles = true
        }
    }
    
    private func loadCollectionJson() {
        let collectionJsonURL = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        guard let url = URL(string: collectionJsonURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                //alert user
                print(error!)
                return
            } else {
                guard let data = data else { return }
                do {
                    let collectionArray = try JSONDecoder().decode(CollectionArray.self, from: data)
                    self.collections = [Collection]()
                    
                    for collection in collectionArray.custom_collections {
                        var collectionCell = Collection()
                        collectionCell.title = collection.title
                        collectionCell.id = collection.id
                        collectionCell.image = collection.image
                        collectionCell.body_html = collection.body_html
                        collectionCell.image?.src = (collection.image?.src)!
                        self.collections?.append(collectionCell)
                    }
    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                    
                } catch let jsonErr {
                    //change alert message?
                    print(jsonErr)
                }
            }
            }.resume()
    }
    
    private func collectionViewSetup() {
        collectionView.backgroundColor = UIColor.rgb(red: 92, green: 106, blue: 196)
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(title)
        title.leftAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
        title.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: -40).isActive = true
        title.text = "Your Collections"
        title.textColor = UIColor.white
        let fontDescriptor = UIFontDescriptor(name: "HelveticaNeue-Bold", size: 0)
        title.font = UIFont(descriptor: fontDescriptor, size: 25)
    }
    
}

