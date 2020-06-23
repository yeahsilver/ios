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
    
//    var name:String?
//    var bounty: Int?

    var bountyInfo: BountyInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil) // 닫기 액션
    }
    
    func updateUI(){
        if let bountyInfo = self.bountyInfo{
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
        
//        if let name = self.name, let bounty = self.bounty{
//            let img = UIImage(named: "\(name).jpg")
//            imgView.image = img
//            nameLabel.text = name
//            bountyLabel.text = "\(bounty)"
//        }
       
    }
}
