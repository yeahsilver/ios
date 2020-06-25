//
//  BountyViewController.swift
//  BountyList
//
//  Created by 허예은 on 2020/06/21.
//  Copyright © 2020 허예은. All rights reserved.
//

import UIKit

class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let viewModel = BountyViewModel()
    //MVVM
    
    //Model
    // - bountyInfo
    // > bountyInfo 만들기
    
    // View
    // ListCell
    // > ListCell 필요한 정보를 ViewModel에서 받기
    // > ListCell은 ViewModel로부터 받은 정보로 뷰 업데이트 하기.
    
    // ViewModel
    // - bountyViewModel
    // > bountyViewModel 만들기, 뷰 레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기 (BountyInfo 등)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // segue를 수행하면 해당 데이터를 수집하여 보내기.
        // detailViewController에게 data를 줌.
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int{
                
                //let bountyInfo = bountyInfoList[index]
                let bountyInfo = viewModel.bountyInfo(at: index)
//                vc?.name = bountyInfo.name
//                vc?.bounty = bountyInfo.bounty
                
                vc?.viewModel.update(model: bountyInfo)
                
//                vc?.name = nameList[index]
//                vc?.bounty = bountyList[index]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // UICollectionViewDataSource
    // 몇개를 보여줄까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfo
    }
    // 셀은 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as?
                GridCell else { return UICollectionViewCell() }
            
            let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
                cell.update(info: bountyInfo)
            cell.update(info: bountyInfo)
            return cell
    }
    
    // UICollectionViewDelegate
    // 셀이 클릭되었을 때 어떨까요?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("--> \(indexPath.item)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.item) // segue에 정보를 넣어주는 역할을 함!
    }
    
    // UICollectionViewDelegateFlowLayout
    // 셀 사이즈를 계산 (다양한 디바이스에서 일관적인 디자인을 보여주기 위해)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height: CGFloat = width * 10/7 + textAreaHeight
        
        return CGSize(width: width, height: height)
    }
}

class GridCell: UICollectionViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info :BountyInfo){
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}

struct BountyInfo {
    let name: String
    let bounty : Int
    
    var image:UIImage?{
        return UIImage(named:"\(name).jpg")
    }
    
    init(name: String, bounty: Int){
        self.name = name
        self.bounty = bounty
    }
}

class BountyViewModel{
    let bountyInfoList:[BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 4400000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 7700000),
        BountyInfo(name: "zoro", bounty: 120000000)
    ]
    
    var sortedList: [BountyInfo]{
        let sortedList = bountyInfoList.sorted { (prev, next) -> Bool in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    var numOfBountyInfo: Int{
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo{
        return sortedList[index]
    }
}

