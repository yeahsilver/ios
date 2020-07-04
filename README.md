# 👩🏻‍💻 IOS Swift

[![Swift](http://img.shields.io/badge/Swift-v.5.1-blue.svg?style=flat)](https://developer.apple.com/swift/)[![Swift](http://img.shields.io/badge/xcode-v.11.5-orange.svg?style=flat)](https://developer.apple.com/xcode/whats-new/)

##### ✨ 제가 생각하기에 필요하거나 헷갈리는 부분만 정리해놓았습니다. 이론상의 순서와 맞지 않을 수 있으니 참고하시면서 봐주시면 감사하겠습니다 :) ✨



## ✏️ 목차

- [App Delegate](#app-delegate)
- [Scene Delegate](#scene-delgate)
- [View Controller](#view-controller)
- [UIViewController Lifecycle](#uivIewcontroller-lifecycle)
- [Constraints](#constraints)
- [Design Pattern](#디자인-패턴)
- [Segue](#segue)
- [Animation](#Animation)



## App Delegate

- App이 해야할 일(background / foreground 진입, 외부에서의 요청 등) 을 대신 구현함

1. 앱의 가장 중요한 데이터 구조를 초기화
2. 앱의 scene 환경설정(configuration)
3. 앱 밖에서 발생한 알림 (배터리 부족, 다운로드 완료)에 대응
4. 특정한 scenes, views, view controllers에 한정되지 않고 앱 자체를 타겟으로 하는 이벤트에 대응
5. 애플 푸쉬 알람 서비스와 같이 실행 시 요구되는 모든 서비스를 등록

  

- UIApplicationMain: entry point와 앱의 입력 이벤트를 전달하는 run loop 생성 (이에 대한 응답으로 시스템은 응용프로그램 객체(app의 lifecycle 담당)를 생성 -> 시스템에서 앱을 실행)

- UIApplicationDelegate: 앱을 세팅하고, 앱 상태 변화에 응답하며, 다른 app-level 이벤트를 처리하는데 사용하는 여러가지 방법을 정의한 메소드의 set

  - var window: UIWindow?: 앱의 window에 대한 참조를 저장. 앱의 view 계층구조의 루트를 나타냄. 
    - window는 optional property임 (UIWindow?이기에)

- UIResponder: 이벤트에 대한 응답 등과 같은 처리를 위한 추상 인터페이스.

  - 이벤트의 흐름

    <img width="878" alt="스크린샷 2020-07-03 오후 5 55 13" src="https://user-images.githubusercontent.com/39258902/86451772-59d21a00-bd56-11ea-93bc-da04297c5970.png">


    1. 이벤트(버튼 클릭 등)를 UIEvent로 변환해서 실행 중인 어플리케이션 객체인 UIApplication의 sendEvent 메서드를 호출한다.
    
    2. UIApplication의 sendEvent 메서드는 UIWindow에게 sendEvent를 다시 보낸다.
    
    3. UIWindow는 이벤트에 해당하는 메시지를 자식 뷰 중에서 최초 응답 객체에 보낸다.
    
    4. 최초 응답 객체가 이벤트를 처리하고, 이벤트는 소멸된다.


​       

- Scene Session이 생성되거나 삭제될 때 AppDelegate에 알리는 메소드 추가. (Scene session은 앱에서 생성한 모든 scene의 정보를 관리)

```swift
// 어플리케이션이 최초 실행되는 지점
application: UIApplication, didFinishLaunchingWithOptions

// 어플리케이션에서 가져온 초기 configuration data(구성 데이터)를 로드해주는 지점 (새로운 scene session이 생성되었을 때 호출)
application: UIApplication, configurationForConnecting

// 어플리케이션이 완전히 종료되기 전 시점 (user가 Scene을 닫을 때 호출)
application: UIApplication, didDiscardSceneSessions
```




## Scene Delegate

: UI 상태를 알 수 있는 UILifeCycle에 대한 역할을 함.

- Scene: UI의 하나의 인스턴스를 나타내는 windows와 view controllers가 들어있음. 각 scene에 해당하는 UIWindowSceneDelegate 객체를 가지고 있음.
  - appDelegate에서 scene session을 통해 scene에 대한 정보를 업데이트 받음.
- Scene Session: scene의 고유한 런타임 인스턴스 관리.

- UIWindowSceneDelegate: UIKit와 앱 간의 상호작용을 조정하는데 사용
- UIResponder: 위의 내용과 동일

```swift
// scene의 연결이 해제될 때 호출
sceneDidDisconnect(_:)

// scene과 상호작용이 시작될 때 호출
sceneDidBecomeActive(_:)

// 사용자가 scene과 상호작용을 중지할 때 호출 ex) 다른 화면으로 전환할 때
sceneWillResignActive(_:)

// scene이 포그라운드로 진입할 때 호출
sceneDidEnteForeground(_:)

// scene이 백그라운드로 진입할 때 호출
sceneDidBackground(_:)

```

<img width="955" alt="스크린샷 2020-07-03 오후 5 55 34" src="https://user-images.githubusercontent.com/39258902/86451813-66ef0900-bd56-11ea-8198-970a77c29244.png">



## View Controller

: 어플리케이션의 인터페이스와 인터페이스와 데이터 간의 상호작용을 관리

- UIViewController: view의 속성과 메소드를 정의 
  - content view controllers: 어플리케이션 내용을 관리 
  - Container view controllers: 다른 view controller에 있는 정보를 수집한 뒤 효율적인 방향 제시

<img width="661" alt="스크린샷 2020-07-04 오후 9 58 37" src="https://user-images.githubusercontent.com/39258902/86512996-857dfe80-be41-11ea-9f97-275cb7df8324.png">



### UIVIewController Lifecycle

- init: View Controller를 초기화하는 메소드
- viewDidLoad: view가 메모리에 로드된 뒤 실행하는 메소드
- viewWillAppear: view를 사용자의 스크린에 띄우기 위해 사용하는 메소드 ex) scroll할때 나타나는 정보
- viewDidAppear: view를 사용자의 스크린에 띄운 뒤 실행하는 메소드 + 애니메이션의 시작을 정의
- viewWillDisappear: view가 사용자의 스크린에 꺼지기 직전 실행되는 메소드. Ex) 임의의 텍스트를 바꾸면 직전의 텍스트를 저장해주는 역할?
- viewDidDisappear: 스크린이 완전히 꺼졌을 때 실행되는 메소드

<img width="770" alt="스크린샷 2020-07-04 오후 11 00 32" src="https://user-images.githubusercontent.com/39258902/86514068-2cff2f00-be4a-11ea-972b-e9dc10583b36.png">



## Constraints

- leading space: 전체화면과 component의 왼쪽 끝의 거리를 지정해주는 것 (왼쪽 마진과 비슷)
- Trailing space: 전체화면과 component의 오른쪽 끝의 거리를 지정해주는 것(오른쪽 마진과 비슷)

- center vertically in container: y축을 기준으로  component의 위치를 가운데로 지정해주는 것.

- center horizontally in container: x축을 기준으로 component의 위치를 가운데로 지정해주는 것

- horizontal spacing: 두개의 component의 사이의 spacing을 지정해주는 것

- Equal width: component의 길이를 동일하게 지정해주는 것. (동일한 길이를 지정해주어야지 경고창이 뜨지 않음.)

- Aspect ratio: width와 height의 비율을 지정해주는 것

- Top: 지목된 component의 위쪽 spacing을 지목한 component와 같게 지정.

- Bottom: 지목된 component의 아래쪽 spacing을 지목한 component와 같게 지정.

  

## 디자인 패턴

> 디자인 패턴을 사용하는 이유: 각각의 역할을 나눠 코드를 관리하게 된다면, 유지보수와 개발 효율이 좋아짐


### MVC (Model + View + Controller)

#### - MVC의 구조

- Model: 어플리케이션에서 사용되는 데이터와 그 데이터를 처리하는 부분
- View: 사용자에게 보여지는 UI부분
- Controller: 사용자의 액션을 받고 처리하는 부분

<img width="466" alt="스크린샷 2020-07-03 오후 5 55 57" src="https://user-images.githubusercontent.com/39258902/86451865-74a48e80-bd56-11ea-859c-a68ef69b8ac5.png">



#### - MVC의 동작순서

1. controller가 사용자의 action을 받음

2. 사용자의 action을 확인한 controller는 model을 업데이트 시킴

   - View가 Model을 이용하여 직접 업데이트하는 방법
   - Model에서 View에게 Notify하여 업데이트 하는 방법
   - View가 Polling을 통해 주기적으로 Model의 변경을 감지하여 업데이트 하는 방법

3. controller는 Model을 나타내줄 View를 선택

4. View는 Model을 이용하여 화면을 나타냄

   

#### - MVC의 특징

- controller는 여러개의 view를 선택할 수 있음
- controller는 view를 선택할 뿐이지 직접 업데이트를 하지 않음 (view는 controller를 알지 못하는 형태)



#### - MVC의 장점

- 단순한 구조 -> 보편적으로 사용되는 디자인 패턴



#### - MVC의 단점

- view와 model 사이의 의존성이 높음. 
  - 높은 의존성은 어프리케이션의 규모가 증가하면 복잡하고, 유지보수가 어려울 수 있음.

- model만 테스트 가능




### MVP (Model + View + Presenter)

#### - MVP의 구조

- Model: 어플리케이션에서 사용되는 데이터와 그 데이터를 처리하는 부분
- View: 사용자에게 보여지는 UI부분
- Presenterr: View에서 요청한 정보를 기반으로 model을 가공하여 view에 전달해주는 부분

<img width="439" alt="스크린샷 2020-07-03 오후 6 26 34" src="https://user-images.githubusercontent.com/39258902/86454792-bcc5b000-bd5a-11ea-9c48-8fa4188912b9.png">



#### - MVP의 동작

1. View가 사용자의 Action을 받음
2. view는 데이터를 presentor에 요청
3. presenter는 model에게 데이터 요청
4. model은 presentor에서 요청받은 데이터에 response.
5. presenter가 view에게 응답된 데이터를 전송
6. view는 presentor가 전송한 데이터를 기반으로 화면을 구성함.



#### - MVP의 특징

- Presenter는 view와 model의 인스턴스를 가지고 있기에, 둘을 연결시키는 접착제 역할을 수행함
- presentor와 view는 1:1 관계이다.



#### - MVP의 장점

- view와 model 사이의 의존성이 존재하지 않음. 
  - view와 model은 presentor를 통해 데이터를 전달받기 때문에.



#### - MVP의 단점

- view와 presentor의 의존성이 존재하여, 어플리케이션의 규모가 커질수록 둘사이의 의존성이 강해짐





### MVVM (Model + View + View Model)

#### - MVVM의 구조

- Model: 어플리케이션에서 사용되는 데이터와 그 데이터를 처리하는 부분 (데이터의 틀)
- View: 사용자에게 보여지는 UI부분
- View Model: View를 표현하기 위해 만든 View를 위한 Model. View를 나타내주기 위한 Model이자 View들을 나타내기 위한 데이터 처리를 담당하는 부분. (데이터 저장 부분)

<img width="496" alt="스크린샷 2020-07-03 오후 6 33 13" src="https://user-images.githubusercontent.com/39258902/86455504-a9671480-bd5b-11ea-9565-ec4dff226c7d.png">



#### - MVVM의 작동 방식

1. View를 통해 사용자의 action이 들어옴
2. view에 action이 들어오면, command 패턴으로 view model에 action을 전달
3. view model은 model에게 데이터 요청
4. model은 요청받은 데이터를 view model에 전달
5. view model은 응답받은 데이터를 가공하여 저장
6. View는 view model과 data binding을 하며 화면을 나타냄

*- 데이터 바인딩: 화면에 보이는 데이터와 메모리에 있는 데이터를 일치시키는 기법*

*- command 패턴: 실행될 기능을 캡슐화함으로써 주어진 여러 기능을 실행할 수 있는 재사용성이 높은 클래스를 설계하는 패턴*



#### - MVVM의 특징

- command 패턴과 data binding 두가지 패턴을 사용하여 구현
- command 패턴과 data binding을 이용하여 view와 view model 사이의 의존성을 없앰
- view model과 view는 1:n 관계임



#### - MVVM의 장점

- view와 model 사이 / view와 view model 사이의 의존성이 없음. 
- 각 부분의 독립성으로 인해 모듈화하여 개발 가능



#### - MVVM의 단점

- view model 설계가 어려움





### VIPER

#### - VIPER의 구조

- View: 사용자에게 보여지는 UI부분 / user interaction을 받는 역할
- interactor: presentor로 부터 받은 모델 변경사항에 따라 entity에 접속하여 entity로부터 수신한 데이터를 Presenter로 전달하는 부분
- presenter: view와 interactor의 중간다리 역할. view에 대한 비즈니스 로직
- entity: 네트워크, DB등의 데이터 모델
- Router: VIPER 컴포넌트들의 dependency injection을 담당. (의존성을 낮춤) / 화면간의 탐색을 위한 라우팅 담당(어떻게 화면 전환이 될 것인지를 관리함.)

<img width="893" alt="스크린샷 2020-07-03 오후 9 25 34" src="https://user-images.githubusercontent.com/39258902/86469113-bd1e7500-bd73-11ea-86c3-c75bfdf00f00.png">



#### - VIPER의 작동 원리

1. view에서 이벤트가 발생하면 presenter가 해당 action을 전달 
2. presenter로 받은 모델에 따라서 interactor의 entity에 접속하여 entity로 부터 수신한 데이터를 presenter로 전달.
3. presentor는 interactor로 부터 데이터를 가지고오고, view에 데이터를 보냄.



#### - VIPER의 특징

- 테스트가 용이하다. 

- 양방향 로직 순환

  

#### - VIPER의 장점

- MVP / MVVM / MVC 의 구조 사이에서 제일 분배가 잘 되어있는 구조임.



#### - VIPER의 단점

- 코드양이 가장 많다.
- 작은 기능에도 많은 클래스를 작성해야함
- 메모리 누수 가능성이 높다





### VIP (Clean Swift)

#### - VIP 구조

- view: 사용자에게 보여지는 UI부분 

- Controller: view를 코드에 바인딩하는 레이어

- Interactor: controller의 요청을 보내야하는 비즈니스 로직 계층

- presenter: interactor로부터 받은 형태를 view에 맞게 전달할 수 있게 controller에게 전달

- Router: controller에서 발생한 이벤트를 다른 user case에 전달하는 역할

<img width="646" alt="스크린샷 2020-07-03 오후 9 26 08" src="https://user-images.githubusercontent.com/39258902/86469154-d1627200-bd73-11ea-99d3-b192c1443e85.png">



#### - VIP 작동 원리

1. view가 사용자 인터페이스 생성
2. controller에서 이벤트가 발생하여 모델을 요청 후 interactor 호출
3. interactor에서는 기본 코어 라이브러리를 호출하여 데이터를 엑세스
4. interactor에서 비즈니스 로직을 처리하고 결과를 다시 presenter에 보냄
5. Presenter에서 interactor에서 받은 결과에 대한 UI처리를 controller에 전달하여 view에 보여줌.



#### - VIP의 특징

- 단방향 cycle로 구성되어있음. ( interactor -> presenter -> view controller -> interaction)
- presentor는 interactor과 직접적으로 소통 불가
- 클래스 의존성을 해결하기 위해 나온 구조 (모듈 의존성보다 클래스 의존성을 중점으로 두고 만듦. )



#### - VIP의 장점

- 액션에 대한 비즈니스 로직을 presenter를 통하지 않고 바로 interactor에 요청해서 변화를 주며 단방향으로 플로우 진행
- 확장성이 좋음
- 모든 layer가 인터페이스로 존재하기에, 테스트에 용이



#### - VIP의 단점

- layer끼리 전달할때 request / response 모델을 랩핑해야하는 불편함이 존재
- 모델을 랩핑하지 않을 경우, 컴포넌트가 결합될 수 있음
- 비동기 액션에 대한 처리가 별도로 필요함



## Collection View

- Items: 스크린에 디스플레이 하고 싶은 각각의 데이터를 나타냄 ex) 사진
- Groups: 여러개의 item을 가지고 있음. 어디에 레이아웃 위치해야하는지를 나타냄
- Sections: data를 묶어놓은 것. datasource에서 어떻게 데이터가 구성되어있는지를 알려주는 역할.



#### Collection View의 구성요소

<img width="729" alt="스크린샷 2020-07-04 오후 10 33 19" src="https://user-images.githubusercontent.com/39258902/86513590-5e75fb80-be46-11ea-8a92-f17fffda4382.png">

#### UICollectionViewDataSource

: 데이터와 collection view가 요구하는 view를 제공

- 얼마나 많은 section이 collection view에 들어갈 것인지
- 주어진 section에서 얼마나 많은 item이 section안에 삽입될 것인지
- 주어진 section과 item에서, 상응하는 내용이 보여지기 위해 어떠한 view를 사용해야하는지

#### UICollectionViewDelegate

- collection view 내부에서 선택하거나 중요한 item을 관리
-  item에 대한 행동을 수행



#### UICollectionViewDelegateFlowLayout

- item의 사이즈를 정의
- grid와 item 사이의 거리를 정의



## Segue

: 스토리보드에서 뷰 컨트롤러 사이의 화면전환을 위해 사용하는 객체

#### Segue 작동법

1. 세그웨이 식별자를 가져온 값을 가지고 해당 뷰가 맞는지(identifier가 같은지) 비교
2. 맞으면 목적지 뷰로 캐스팅.
   - 이때, 목적지 뷰를 설정한 뒤, 목적지 뷰에 전달받아야 하는 변수를 참조하여 이동할 값을 할당.



## Animation

### UIKit의 애니메이션 API

```swift
// 기본 타이밍 함수를 이용하여 애니메이션 로드
animate(withDuration: animations:)

// 완료 핸들러 추가
animate(withDuration: animations: completion: )

//딜레이 및 다른 애니메이션 옵션 사용
animate(withDuration: delay: options: animations: completion: )

// 일반적인 곡선 타이밍 함수가 아닌 스프링에 의한 타이밍 함수를 사용하여 애니메이팅하는 함수
animate(withDuration: delay: usingSpringWithDamping: initialSpringVelocity: options: animations: completion: )

// 키 프레임 애니메이션 표시
animateKeyframes(withDuration: delay: options: animations: completion:)

// 뷰 트랜지션
transition(with: duration: options: animations: completion: )

// 제 3의 뷰를 트렌지션
transition(_: on: options: animations: completion: )
```



### CGAffineTransform

: 뷰의 프레임을 계산하지 않고 2D 그래픽을 그리는 방법

- Scale: 뷰의 넓이와 높이를 배로 증가시키는 역할
- Rotate: 뷰를 회전
- Translate: 뷰의 위치를 변경

```Swift
CGAffineTransform(translationX: view.bounds.width, y:0).scaledBy(x: 3, y:3).rotated(by: 180)
// view.bounds.width만큼 x축으로 이동하고, x와 y를 3배로 늘린 후 180도 회전
```




## 📍 Reference List

- [Roles of AppDelegate](https://zeddios.tistory.com/218)
- [Roles of SceneDelegate](https://velog.io/@dev-lena/iOS-AppDelegate와-SceneDelegate)
- [Roles of View Controller](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/index.html)
- [UIViewController Lifecycle](https://www.zerotoappstore.com/what-is-uiviewcontroller-lifecycle.html)
- [Constraints](https://www.youtube.com/watch?v=pwkpyzn7EOM)
- [Design Patterns](https://beomy.tistory.com/43)
- [Design Patterns - VIPER / VIP](https://dev-leeyang.tistory.com/21)
- [Components of Collection View 1](https://www.youtube.com/watch?v=CcLJk_YttTI)
- [Components of Collection View 2](https://www.iosdevlog.com/pro_ios_table_views_and_collection_views/2016/04/23/Collection-Views-Quick-Start.html)
- [UICollectionViewDataSource](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCellsandViews/CreatingCellsandViews.html)
- [Segue](https://thd0011.tistory.com/44)
- [CGAffineTransform](https://hyerios.tistory.com/14)

