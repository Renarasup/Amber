//
//  PackageInformationViewController.swift
//  Amber
//
//  Created by Giancarlo Buenaflor on 24.12.18.
//  Copyright © 2018 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PackageInformationViewController: BaseViewController {
    
    var package: Package?
    
    // UI Views
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        return cv
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .PackagesButtons
        pc.numberOfPages = package?.pages.count ?? 0
        return pc
    }()
    
    private let unlockButton = UIButton()
    private let titleLabel = BaseLabel(font: .large, textColor: .lightGray, numberOfLines: 1)
    private let strikedThroughLabel = BaseLabel(font: .bold, textColor: .lightGray, numberOfLines: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .Main
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PackageInformationCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        
        unlockButton.backgroundColor = .PackagesButtons
        unlockButton.setTitleColor(.white, for: .normal)
        unlockButton.titleLabel?.font = .regular
        unlockButton.layer.cornerRadius = Constants.smallCornerRadius
        
        setupViewsLayout()
    }
    
    private func setupViewsLayout() {
        
        view.add(subview: collectionView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.65)
            ]}
        
        view.add(subview: pageControl) { (v, p) in [
            v.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
        
        view.add(subview: unlockButton) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -Constants.padding),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: Constants.padding),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -Constants.padding),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.07)
            ]}
        
        view.add(subview: strikedThroughLabel) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: unlockButton.topAnchor, constant: -Constants.padding),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
    }
    
    override func setupUI() {
        super.setupUI()
        
    }
    
    init(package: Package) {
        super.init(nibName: nil, bundle: nil)
        self.package = package
        
        let titleLabel = BaseLabel(text: package.title, font: .regular, textColor: .Tint, numberOfLines: 1)
        navigationItem.titleView = titleLabel
        
        unlockButton.setTitle("Unlock for €\(String(format: "%.2f", package.price))".replacingOccurrences(of: ".", with: ","), for: .normal)
        
        if package == .allInOne {
            let mutableString = NSMutableAttributedString()
            
            let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: "€1,80")
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            
            let discountAttributedString = NSAttributedString.String("   30% Discount", font: .bold, color: UIColor(rgb: 0xcd6133))
            
            mutableString.append(attributedString)
            mutableString.append(discountAttributedString)
            
            strikedThroughLabel.attributedText = mutableString
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
    }
}

extension PackageInformationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(PackageInformationCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let package = package else {
            return 0
        }
        return package.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let package = package else {
            return
        }
        
        let cell = cell as! PackageInformationCell
        
        cell.model = package.pages[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

