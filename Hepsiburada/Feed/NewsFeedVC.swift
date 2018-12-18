//
//  NewsFeedVC.swift
//  Hepsiburada
//
//  Created by eyupcimen on 21.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SDWebImage
import SVProgressHUD


class NewsFeedVC: BaseVC , AddProductBasketDelegate {


    @IBOutlet var iCarousel: iCarousel!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var menuTableView: UITableView!
    @IBOutlet var productCollView: UICollectionView!
    @IBOutlet var cnsh_ProdcutHeight: NSLayoutConstraint!
    @IBOutlet var bannerImage: UIImageView!
    
    var VM = NewsFeedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getProducts()
    }

    func setUI(){
        iCarousel.bounces               = false
        iCarousel.isPagingEnabled       = true
        iCarousel.clipsToBounds         = false
        pageControl.isHidden            = false
        pageControl.isUserInteractionEnabled = false
        self.view.backgroundColor = Const.viewBackgroundColor
        self.carouselReloadData()
    }

    func getProducts()  {
        SVProgressHUD.show()
        VM.getProducts(success: { (produts) in
            self.productCollView.reloadData()
            self.adjustHeight(count: produts.count , layoutConstant: self.cnsh_ProdcutHeight )
            SVProgressHUD.dismiss()
        }, fail: { (error) in
            SVProgressHUD.dismiss()
            print("\(error)")
        })
        
        VM.getCarouselImagesUrl(success: { (carouselUrlArr) in
            self.VM.carouselImages = carouselUrlArr
            self.carouselReloadData()
            SVProgressHUD.dismiss()
        }, fail: { (error) in
            SVProgressHUD.dismiss()
            print("\(error)")
        })
        
        VM.getBannerUrl(success: { (bannerUrl) in
            let url = URL(string: bannerUrl)
            self.bannerImage.sd_setImage(with: url , placeholderImage: UIImage(named:"default") , options: SDWebImageOptions.continueInBackground, completed: nil)
            SVProgressHUD.dismiss()
        }, fail: { (error) in
            SVProgressHUD.dismiss()
            print("\(error)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func adjustHeight ( count : Int , layoutConstant : NSLayoutConstraint )  {
        let cons = count / 2
        if (  count <= 2  ) {
            layoutConstant.constant = CGFloat(250)
        } else if ( count > 3 ) {
            layoutConstant.constant = CGFloat(250 * (cons + 1) )
        }
    }

    @IBAction func bannerBtnClicked(_ sender: UIButton) {
        if VM.bannerUrl != nil {
            let url = URL(string: VM.bannerUrl!)
            self.alertWithCompletion(bannerUrl: url!)
        }
    }


    @IBAction func sideMenuAction(_ sender: UIButton) {
        self.simpleAlert(message: "Side Menüye tıklandı!")
    }

    @IBAction func profileMenuAction(_ sender: UIButton) {
        self.simpleAlert(message: "Profile Menüsüne tıklandı!")
    }
}

extension NewsFeedVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = Const.avenirNextLTPro
        cell.textLabel?.textColor = Const.cellTextColor
        switch indexPath.row {
        case 0:
            cell.textLabel?.text    = "Kampanyalar"
        case 1:
            cell.textLabel?.text    = "Size Özel"
        case 2:
            cell.textLabel?.text    = "Girişimci Kadınlar"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func userProductAddedBasket(productName: String) {
        simpleAlert(message: "\(productName) sepete eklendi")
    }
}

extension NewsFeedVC : iCarouselDelegate , iCarouselDataSource  {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return VM.carouselImages.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: iCarousel.frame.size.width , height: iCarousel.frame.size.height ) )
        view.backgroundColor = .clear
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: carousel.frame.size.width , height: carousel.frame.size.height) )
        let url = URL(string: VM.carouselImages[index])
        imageView.sd_setImage(with: url , placeholderImage:UIImage(named: "default_big") , options: SDWebImageOptions.continueInBackground, completed: nil)
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        view.addSubview(imageView)
        return view
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.1
        }
        return value
    }
    
    
    func carouselDidScroll(_ carousel: iCarousel) {
        self.pageControl.currentPage = carousel.currentItemIndex
    }
    
    func carouselReloadData () {
        iCarousel.bringSubview(toFront: pageControl)
        self.pageControl.numberOfPages = VM.carouselImages.count;
        iCarousel.reloadData()
    }
}


extension NewsFeedVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VM.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsFeedCell
        let model : Products =  VM.products[indexPath.row]
        cell.reloadData( model: model )
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var newSize = CGSize.zero
        newSize.width   = (self.productCollView.bounds.size.width - 1 ) / 2
        newSize.height  = 250
        return newSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0 }
}












