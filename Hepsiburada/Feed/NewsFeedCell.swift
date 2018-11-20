//
//  ProductCollViewCell.swift
//  Hepsiburada
//
//  Created by eyupcimen on 22.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import UIKit
import SDWebImage

protocol AddProductBasketDelegate : class {
    func userProductAddedBasket(productName: String)
}


class NewsFeedCell: UICollectionViewCell ,  iCarouselDelegate , iCarouselDataSource {

    @IBOutlet var productCarousel   : iCarousel!
    @IBOutlet var pageControl       : UIPageControl!
    @IBOutlet var titleLbl          : UILabel!
    @IBOutlet var previewCount      : UILabel!
    @IBOutlet var firstStarImage    : UIImageView!
    @IBOutlet var secondStarImage   : UIImageView!
    @IBOutlet var thirdStarImage    : UIImageView!
    @IBOutlet var fourthStarImage   : UIImageView!
    @IBOutlet var fifthStarImage    : UIImageView!
    
    @IBOutlet var opportunityOfTheDay: UIView!
    var imageURLs = [String]()
    var delegate : AddProductBasketDelegate?
    var model : Products?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        productCarousel.delegate                = self
        productCarousel.dataSource              = self
        productCarousel.bounces                 = false
        productCarousel.isPagingEnabled         = true
        productCarousel.clipsToBounds           = false
        pageControl.isHidden                    = false
        pageControl.isUserInteractionEnabled = false
    }

    func reloadData ( model : Products )  {
        self.model = model
        imageURLs = model.urls!
        titleLbl.text = model.title
        previewCount.text = "(\(model.reviewCount!))"
        opportunityOfTheDay.isHidden = model.opp_day!
        var fullArr = [UIImageView]()
        switch model.ratingCount  {
        case "1"?:
            fullArr.append(firstStarImage)
        case "2"?:
            fullArr.append(firstStarImage)
            fullArr.append(secondStarImage)
        case "3"?:
            fullArr.append(firstStarImage)
            fullArr.append(secondStarImage)
            fullArr.append(thirdStarImage)
        case "4"?:
            fullArr.append(firstStarImage)
            fullArr.append(secondStarImage)
            fullArr.append(thirdStarImage)
            fullArr.append(fourthStarImage)
        case "5"?:
            fullArr.append(firstStarImage)
            fullArr.append(secondStarImage)
            fullArr.append(thirdStarImage)
            fullArr.append(fourthStarImage)
            fullArr.append(fifthStarImage)
        default:
            fullArr.removeAll()
        }

        for tempImageView in fullArr {
            tempImageView.image = UIImage(named: "star_full")
        }
        reloadData()
    }

    func reloadData ( ) {

        pageControl.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        productCarousel.reloadData()
        productCarousel.bringSubview(toFront: pageControl)
        self.pageControl.numberOfPages = imageURLs.count
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return imageURLs.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: productCarousel.frame.size.width , height: productCarousel.frame.size.height ) )
        view.backgroundColor = .clear
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: carousel.frame.size.width , height: carousel.frame.size.height) )
        let url = URL(string: self.imageURLs[index])
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
    
    @IBAction func addBasketAction(_ sender: UIButton) {
        delegate?.userProductAddedBasket(productName: "\(model!.title!)" )
    }

}
