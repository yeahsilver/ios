import UIKit

// Queue - Main, Global, Custom

// Main
DispatchQueue.main.async {
    // UI update
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

// Global
DispatchQueue.global(qos: .userInteractive).async {
    // 지금 당장해야하는 것
}

DispatchQueue.global(qos: .userInitiated).async {
    // 거의 바로 해줘야할 것
}

DispatchQueue.global(qos: .default).async {
    // 이건 굳이?
}

DispatchQueue.global(qos: .utility).async{
    // 시간이 좀 걸리는 일들, 사용자가 당장 기다리지 않는 것, 네트워킹, 큰 파일 불러올 때
}

DispatchQueue.global(qos: .background).async {
    //사용자에게 당장 인식될 필요가 없는 것들. 뉴스데이터 미리받기, 위치 업데이트, 영상 다운로드
    
}

// custom Queue
let concurrentQueue = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)
let serialQueue = DispatchQueue(label: "serial", qos: .background)

// 복합적인 상황
func downloadImageFromServer() -> UIImage{
    // Heavy Task
    return UIImage()
}

func updateUI(image: UIImage){
    
}

DispatchQueue.global(qos: .background).async{
    let image = downloadImageFromServer()
    
    // main thread로 연결해 주어야함.
    DispatchQueue.main.sync{
        updateUI(image: image)
    }
}

// Sync, Async

//Async
DispatchQueue.global(qos: .background).async{
    for i in 0...5{
        print("A: \(i)")
    }
}

DispatchQueue.global(qos: .userInteractive).async{
    for i in 0...5{
        print("B: \(i)")
    }
}


//Sync
// Sync의 작업이 모두 완료되어야 다음으로 넘어감.
DispatchQueue.global(qos: .background).sync{
    for i in 0...5{
        print("A: \(i)")
    }
}

DispatchQueue.global(qos: .userInteractive).async{
    for i in 0...5{
        print("B: \(i)")
    }
}



