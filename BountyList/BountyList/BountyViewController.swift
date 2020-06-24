//
//  BountyViewController.swift
//  BountyList
//
//  Created by 허예은 on 2020/06/21.
//  Copyright © 2020 허예은. All rights reserved.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
//    let bountyInfoList:[BountyInfo] = [
//        BountyInfo(name: "brook", bounty: 33000000),
//        BountyInfo(name: "chopper", bounty: 50),
//        BountyInfo(name: "franky", bounty: 4400000),
//        BountyInfo(name: "luffy", bounty: 30000000),
//        BountyInfo(name: "nami", bounty: 1600000),
//        BountyInfo(name: "robin", bounty: 80000000),
//        BountyInfo(name: "sanji", bounty: 7700000),
//        BountyInfo(name: "zoro", bounty: 12000000)
//    ]
    
//    let nameList = ["brook", "chopper", "franky", "luffy", "nami", "robin", "sanji", "zoro"]
//    let bountyList = [33000000, 50, 4400000, 30000000, 1600000, 80000000, 7700000, 12000000]
    
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
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
         //return bountyList.count
//        return bountyInfoList.count
        return viewModel.numOfBountyInfo
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        } // guard: 성립되면 밑의 return 아니면 위의 return으로 이동시켜주는 지시어.
        //let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        //cell.imgView.image = img
        //cell.nameLabel.text = nameList[indexPath.row]
        //cell.bountyLabel.text = "\(bountyList[indexPath.row])"
        
//        let bountyInfo = bountyInfoList[indexPath.row]
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
        cell.update(info: bountyInfo)
//        cell.imgView.image = bountyInfo.image
//        cell.nameLabel.text = bountyInfo.name
//        cell.bountyLabel.text = "\(bountyInfo.bounty)"
        return cell
        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell{
//            let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
//            cell.imgView.image = img
//            cell.nameLabel.text = nameList[indexPath.row]
//            cell.bountyLabel.text = "\(bountyList[indexPath.row])"
//            return cell
//
//        } else {
//            return UITableViewCell()
//        }
        //위의 것과 같은 의미.
    }
       
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row) // segue에 정보를 넣어주는 역할을 함!
    }
}

class ListCell: UITableViewCell{
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
        BountyInfo(name: "luffy", bounty: 30000000),
        BountyInfo(name: "nami", bounty: 1600000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 7700000),
        BountyInfo(name: "zoro", bounty: 12000000)
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

