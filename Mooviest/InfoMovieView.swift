//
//  InfoMovieView.swift
//  Mooviest
//
//  Created by Antonio RG on 12/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class InfoMovieView: UIView {

    var ratingCollectionView:UICollectionView!
    
    var synopsisHeaderTitleView = UIView()
    var synopsisLabel = UILabel()
    var synopsisTextView = UITextView()
    
    var genreHeaderTitleView = UIView()
    var genreLabel = UILabel()
    var genreTextView = UITextView()
    
    var producerHeaderTitleView = UIView()
    var producerLabel = UILabel()
    var producerTextView = UITextView()
    
    init() {
        super.init(frame: CGRect.zero)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeader(header:UIView, label: UILabel, key: String,msg: String) {
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        label.text = NSLocalizedString(key, comment:msg)
        label.textColor = UIColor.darkGray
        label.font.withSize(18)
    }
    
    func setupTextView(textView: UITextView) {
        textView.text = "Texto de prueba"
        textView.textContainer.lineFragmentPadding = 20
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = UIColor.gray
        textView.font = UIFont(name: textView.font!.fontName, size: 16)
        textView.isSelectable = false
        textView.isEditable = false
    }

    func setupComponents() {
        self.backgroundColor = UIColor.white
        
        setupHeader(header: synopsisHeaderTitleView, label: synopsisLabel,key: "synopsisLabel",msg: "Text label synopsis")
        setupHeader(header: genreHeaderTitleView, label: genreLabel,key: "genreLabel",msg: "Text label genre")
        setupHeader(header: producerHeaderTitleView, label: producerLabel, key: "producerLabel",msg: "Text label producer")

        setupTextView(textView: synopsisTextView)
        setupTextView(textView: genreTextView)
        setupTextView(textView: producerTextView)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        ratingCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        ratingCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0)
        ratingCollectionView.showsHorizontalScrollIndicator = false
        
        synopsisHeaderTitleView.addSubview(synopsisLabel)
        genreHeaderTitleView.addSubview(genreLabel)
        producerHeaderTitleView.addSubview(producerLabel)
        
        addSubview(ratingCollectionView)
        addSubview(synopsisHeaderTitleView)
        addSubview(synopsisTextView)
        addSubview(genreHeaderTitleView)
        addSubview(genreTextView)
        addSubview(producerHeaderTitleView)
        addSubview(producerTextView)
    }
    
    func setupConstraints() {
        synopsisHeaderTitleView.translatesAutoresizingMaskIntoConstraints = false
        synopsisLabel.translatesAutoresizingMaskIntoConstraints = false
        synopsisTextView.translatesAutoresizingMaskIntoConstraints = false
        ratingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        genreHeaderTitleView.translatesAutoresizingMaskIntoConstraints = false
        producerHeaderTitleView.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        producerLabel.translatesAutoresizingMaskIntoConstraints = false
        genreTextView.translatesAutoresizingMaskIntoConstraints = false
        producerTextView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(ratingCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(ratingCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 20))
        addConstraint(ratingCollectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9))
        addConstraint(ratingCollectionView.heightAnchor.constraint(equalTo: ratingCollectionView.widthAnchor, multiplier: 1/4))
        
        addConstraint(synopsisHeaderTitleView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(synopsisHeaderTitleView.topAnchor.constraint(equalTo:ratingCollectionView.bottomAnchor, constant: 10))
        addConstraint(synopsisHeaderTitleView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(synopsisHeaderTitleView.heightAnchor.constraint(equalTo: widthAnchor, multiplier:0.15))
        
        let porcentLabel = CGFloat(0.95)
        synopsisHeaderTitleView.addConstraint(synopsisLabel.widthAnchor.constraint(equalTo: synopsisHeaderTitleView.widthAnchor, multiplier: porcentLabel))
        synopsisHeaderTitleView.addConstraint(synopsisLabel.topAnchor.constraint(equalTo: synopsisHeaderTitleView.topAnchor))
        synopsisHeaderTitleView.addConstraint(synopsisLabel.rightAnchor.constraint(equalTo: synopsisHeaderTitleView.rightAnchor))
        synopsisHeaderTitleView.addConstraint(synopsisLabel.heightAnchor.constraint(equalTo: synopsisHeaderTitleView.heightAnchor))
        
        addConstraint(synopsisTextView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(synopsisTextView.topAnchor.constraint(equalTo: synopsisHeaderTitleView.bottomAnchor))
        addConstraint(synopsisTextView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(synopsisTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier:0.3))
        
        addConstraint(genreHeaderTitleView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(genreHeaderTitleView.topAnchor.constraint(equalTo:synopsisTextView.bottomAnchor))
        addConstraint(genreHeaderTitleView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(genreHeaderTitleView.heightAnchor.constraint(equalTo: synopsisHeaderTitleView.heightAnchor))
        
        genreHeaderTitleView.addConstraint(genreLabel.widthAnchor.constraint(equalTo: genreHeaderTitleView.widthAnchor, multiplier: porcentLabel))
        genreHeaderTitleView.addConstraint(genreLabel.topAnchor.constraint(equalTo: genreHeaderTitleView.topAnchor))
        genreHeaderTitleView.addConstraint(genreLabel.rightAnchor.constraint(equalTo: genreHeaderTitleView.rightAnchor))
        genreHeaderTitleView.addConstraint(genreLabel.heightAnchor.constraint(equalTo: genreHeaderTitleView.heightAnchor))
        
        addConstraint(genreTextView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(genreTextView.topAnchor.constraint(equalTo: genreHeaderTitleView.bottomAnchor))
        addConstraint(genreTextView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(genreTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier:0.1))
        
        addConstraint(producerHeaderTitleView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(producerHeaderTitleView.topAnchor.constraint(equalTo:genreTextView.bottomAnchor))
        addConstraint(producerHeaderTitleView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(producerHeaderTitleView.heightAnchor.constraint(equalTo: synopsisHeaderTitleView.heightAnchor))
        
        producerHeaderTitleView.addConstraint(producerLabel.widthAnchor.constraint(equalTo: producerHeaderTitleView.widthAnchor, multiplier: porcentLabel))
        producerHeaderTitleView.addConstraint(producerLabel.topAnchor.constraint(equalTo: producerHeaderTitleView.topAnchor))
        producerHeaderTitleView.addConstraint(producerLabel.rightAnchor.constraint(equalTo: producerHeaderTitleView.rightAnchor))
        producerHeaderTitleView.addConstraint(producerLabel.heightAnchor.constraint(equalTo: producerHeaderTitleView.heightAnchor))
        
        addConstraint(producerTextView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(producerTextView.topAnchor.constraint(equalTo: producerHeaderTitleView.bottomAnchor))
        addConstraint(producerTextView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(producerTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier:0.1))
    }
    
    func calculateHeight()-> CGFloat {
        return ratingCollectionView.frame.height + synopsisHeaderTitleView.frame.height*4 +
            synopsisTextView.frame.height + genreTextView.frame.height + producerTextView.frame.height
    }
    
    func setColors(backgroundColor: UIColor, tintColor:UIColor) {
        synopsisHeaderTitleView.backgroundColor = backgroundColor
        synopsisLabel.textColor = tintColor
        genreHeaderTitleView.backgroundColor = backgroundColor
        genreLabel.textColor = tintColor
        producerHeaderTitleView.backgroundColor = backgroundColor
        producerLabel.textColor = tintColor
    }
}
