//
//  PrimarySearchView.swift
//  Foodie
//
//  Created by surya-zstk231 on 21/09/22.
//

import UIKit

enum searchBarNeed {
    case main, search
}

class PrimarySearchView: UIStackView {
    
    var leftImg: UIImageView?
    var rightImg: UIImageView?
    var centerTextView: UIView?
    var searchField: UITextField?
    var leftAction: (() -> ())?
    var rightAction: (() -> ())?
    var updateText: ((String) -> ())?

    override func draw(_ rect: CGRect) {
        print("CALLED")
    }
    
    override func awakeFromNib() {
        print("CALLED")
        self.apply()
    }

    private func apply() {
        axis = .horizontal
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        
        leftImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
        rightImg = UIImageView(frame: CGRect(x: self.frame.width - self.frame.height, y: 0, width: self.frame.height, height: self.frame.height))
        centerTextView = UIView(frame: CGRect(x: self.frame.height, y: 0, width: self.frame.width - self.frame.height - self.frame.height, height: self.frame.height))
        
        guard let leftImg = leftImg , let rightImg = rightImg, let centerTextView = centerTextView else {return}
        leftImg.isUserInteractionEnabled = true
        rightImg.isUserInteractionEnabled = true
        leftImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftBtnTapped)))
        rightImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightBtnTapped)))
        addSubview(leftImg)
        addSubview(centerTextView)
        addSubview(rightImg)
        
        searchField = UITextField(frame: CGRect(origin: .zero, size: centerTextView.frame.size))
        guard let searchField = searchField else {return}
        searchField.autocorrectionType = .no
        searchField.backgroundColor = .orange
        centerTextView.addSubview(searchField)
    }
    
    func boot(val: searchBarNeed) {
        switch val {
        case .main:
            leftImg?.image = UIImage(named: "BackIcon")
            rightImg?.image = UIImage(named: "SearchIcon")
        case .search:
            leftImg?.image = UIImage(named: "BackIcon")
            rightImg?.image = UIImage(named: "SearchIcon")
        }
        searchField?.placeholder = "Search your destination"
        searchField?.delegate = self
    }
    
    @objc func leftBtnTapped() {
        leftAction?()
    }
    
    @objc func rightBtnTapped() {
        rightAction?()
    }
    
}


extension PrimarySearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let txt = textField.text else {return true}
        self.searchField?.endEditing(true)
        self.searchField?.text = nil
        self.updateText?(txt)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let txt = textField.text else {return}
        self.updateText?(txt)
    }
    
}
