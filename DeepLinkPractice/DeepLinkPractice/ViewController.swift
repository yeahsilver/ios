//
//  ViewController.swift
//  DeepLinkPractice
//
//  Created by mac on 2022/01/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func touchUpToConnectKakaotalk(_ sender: UIButton) {
            //URLScheme 문자열 "kakaotalk://"을 통해
            let kakaoTalk = "kakaomap://"
            //URL 인스턴스를 만들어 주는 단계
            let kakaoTalkURL = NSURL(string: kakaoTalk)
            
            
            //canOpenURL(_:) 메소드를 통해서 URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
            if (UIApplication.shared.canOpenURL(kakaoTalkURL! as URL)) {
        
                //open(_:options:completionHandler:) 메소드를 호출해서 카카오톡 앱 열기
                UIApplication.shared.open(kakaoTalkURL! as URL)
            }
            //사용 불가능한 URLScheme일 때(카카오톡이 설치되지 않았을 경우)
            else {
                print("No kakaomap installed.")
            }
        }
}

