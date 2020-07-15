//
//  ViewController.swift
//  test_pageViewController
//
//  Created by 허예은 on 2020/07/15.
//  Copyright © 2020 허예은. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var myControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pages: [String] = ["Chapter 1", "chapter 2", "chapter 3"
        ]
        
        for text in pages {
            let vc = TextViewController(with: text)
            myControllers.append(vc)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.presentPageVC()
        })
    }

    func presentPageVC(){
        guard let first = myControllers.first else {
            return
        }
        
        let vc = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([first],
                              direction: .forward,
                              animated: true,
                              completion: nil)
        
        present(vc, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        
        let before = index - 1
        
        return myControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index < (myControllers.count - 1) else {
            return nil
        }
               
        let after = index + 1
               
        return myControllers[after]
    }

}
