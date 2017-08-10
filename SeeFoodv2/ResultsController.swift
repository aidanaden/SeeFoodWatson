//
//  ResultsController.swift
//  SeeFoodv2
//
//  Created by Aidan Aden on 9/8/17.
//  Copyright © 2017 Aidan Aden. All rights reserved.
//

import UIKit


class ResultsController: UIViewController {
    
    var results = [String]()
    var resultString = ""
    
    let textView: UITextView = {
        
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.isEditable = false
        return tv
    }()
    
    lazy var dismissBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("dismiss", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(dismissBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    func dismissBtnTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(blurEffectView)
        
        for result in results {
            resultString.append("\(result)\n")
        }
        
        setupTextViewAttriubutes()
        setupNavBar()
        
        view.addSubview(textView)
        view.addSubview(dismissBtn)
        
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: view.bounds.width * 2/3).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        dismissBtn.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20).isActive = true
        dismissBtn.widthAnchor.constraint(equalTo: textView.widthAnchor, multiplier: 0.7).isActive = true
        dismissBtn.heightAnchor.constraint(equalToConstant: 85).isActive = true
        dismissBtn.centerXAnchor.constraint(equalTo: textView.centerXAnchor).isActive = true
    }
    
    func setupTextViewAttriubutes() {
        
        let attributedText = NSMutableAttributedString(string: resultString, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName: UIColor.white])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let length = resultString.characters.count
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
        
//        let myShadow = customShadow()
        
//        attributedText.addAttributes([NSShadowAttributeName: myShadow], range: NSRange(location: 0, length: length))
        
        textView.attributedText = attributedText
    }
    
    func setupNavBar() {
        
        let navigationItem = UINavigationItem(title: "Results")
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 84))
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        navigationBar.backgroundColor = .clear
        
//        let myShadow = customShadow()
//        myShadow.shadowBlurRadius = 10
        
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 32, weight: UIFontWeightMedium), NSForegroundColorAttributeName: UIColor.white]
        
        navigationBar.pushItem(navigationItem, animated: false)
        
        view.addSubview(navigationBar)
    }
    
    func customShadow() -> NSShadow {
        
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 5
        myShadow.shadowOffset = CGSize(width: 1, height: 1)
        myShadow.shadowColor = UIColor.black
        
        return myShadow
    }
}













