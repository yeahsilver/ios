//
//  ViewController.swift
//  SwiftLocation
//
//  Created by mac on 2022/01/19.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getWifiAddress())
    }
    
    private func getWifiAddress() -> String? {
        var address: String?
        
        var ipaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ipaddr) == 0 else { return nil}
        guard let firstAddr = ipaddr else { return nil}
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next} ) {
            let interface = ifptr.pointee
            
            let addrFamily = interface.ifa_addr.pointee.sa_family
            let addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INet6) {
                
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                  
                }
            }
        }
        
        return address
    }
}

