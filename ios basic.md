# IOS 기초

### App Delegate

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

    <img src="/Users/heoyeeun/Library/Application Support/typora-user-images/스크린샷 2020-07-03 오후 4.22.25.png" alt="스크린샷 2020-07-03 오후 4.22.25" style="zoom:50%;" />

    1. 이벤트(버튼 클릭 등)를 UIEvent로 변환해서 실행 중인 어플리케이션 객체인 UIApplication의 sendEvent 메서드를 호출한다.

    2. UIApplication의 sendEvent 메서드는 UIWindow에게 sendEvent를 다시 보낸다.

    3. UIWindow는 이벤트에 해당하는 메시지를 자식 뷰 중에서 최초 응답 객체에 보낸다.

    4. 최초 응답 객체가 이벤트를 처리하고, 이벤트는 소멸된다.

       

- Scene Session이 생성되거나 삭제될 때 AppDelegate에 알리는 메소드 추가. (Scene session은 앱에서 생성한 모든 scene의 정보를 관리)

```swift
// 어플리케이션이 최초 실행되는 지점
application: UIApplication, didFinishLaunchingWithOptions

// 어플리케이션에서 가져온 초기 configuration data(구성 데이터)를 로드해주는 지점 (새로운 scene session이 생성되었을 때 호출)
application: UIApplication, configurationForConnecting

// 어플리케이션이 완전히 종료되기 전 시점 (user가 Scene을 닫을 때 호출)
application: UIApplication, didDiscardSceneSessions
```





### SceneDelegate

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

![스크린샷 2020-07-03 오후 5.02.05](/Users/heoyeeun/Library/Application Support/typora-user-images/스크린샷 2020-07-03 오후 5.02.05.png)



### Constraint

- leading space: 전체화면과 component의 왼쪽 끝의 거리를 지정해주는 것 (왼쪽 마진과 비슷)
- Trailing space: 전체화면과 component의 오른쪽 끝의 거리를 지정해주는 것(오른쪽 마진과 비슷)

- center vertically in container: y축을 기준으로  component의 위치를 가운데로 지정해주는 것.
- center horizontally in container: x축을 기준으로 component의 위치를 가운데로 지정해주는 것
- horizontal spacing: 두개의 component의 사이의 spacing을 지정해주는 것
- Equal width: component의 길이를 동일하게 지정해주는 것. (동일한 길이를 지정해주어야지 경고창이 뜨지 않음.)
- Aspect ratio: width와 height의 비율을 지정해주는 것
- Top: 지목된 component의 위쪽 spacing을 지목한 component와 같게 지정.
- Bottom: 지목된 component의 아래쪽 spacing을 지목한 component와 같게 지정.