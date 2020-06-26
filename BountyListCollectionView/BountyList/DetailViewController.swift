//
//  DetailViewController.swift
//  BountyList
//
//  Created by 허예은 on 2020/06/22.
//  Copyright © 2020 허예은. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MVVM
    
    //Model
    // - bountyInfo
    // > bountyInfo 만들기
    
    // View
    // - imgView, nameLabel, bountyLabel
    // > view들은 viewModel을 통해서 구현.
    
    // ViewModel
    // - DetailViewModel
    // > 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기 (bountyInfo 등)
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    
    @IBOutlet var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet var bountyLabelCenterX: NSLayoutConstraint!
    
    
    let viewModel = DetailViewModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    private func prepareAnimation(){
        nameLabelCenterX.constant = view.bounds.width
        bountyLabelCenterX.constant = view.bounds.width
    }
    
    private func showAnimation(){
        nameLabelCenterX.constant = 0
        bountyLabelCenterX.constant = 0
        
//        UIView.animate(withDuration: 0.3){
//            self.view.layoutIfNeeded()
//        }
        
//        UIView.animate(withDuration: 0.3,
//                       delay: 0.1,
//                       options: .curveEaseIn,
//                       animations:{
//            self.view.layoutIfNeeded()
//        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations:{ self.view.layoutIfNeeded()}, completion: nil)
        
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil) // 닫기 액션
    }
    
    func updateUI(){
        
        if let bountyInfo = viewModel.bountyInfo{
                  imgView.image = bountyInfo.image
                  nameLabel.text = bountyInfo.name
                  bountyLabel.text = "\(bountyInfo.bounty)"
              }
    }
}


class DetailViewModel{
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?){
        bountyInfo = model
    }
}
