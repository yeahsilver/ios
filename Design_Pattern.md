# Design Pattern

### Design pattern을 사용하는 이유

- 기술 부채 최소화
- 재사용 및 지속 가능



### MVVM (Model - View - ViewModel)

- Model = 데이터 (struct)
- View = UI요소(UIView, UIViewController)
- ViewModel = 중계자 (ViewModel)

 <img src="/Users/heoyeeun/Library/Application Support/typora-user-images/스크린샷 2020-06-23 오후 4.28.12.png" alt="스크린샷 2020-06-23 오후 4.28.12" style="zoom:50%;" />



### MVC (Model - View - Controller)

- Model = 데이터 (struct)

- View = UI요소 (UIView)

- ####Controller = 중계자 (UIViewController) ==> 기술 부채의 원인.

<img src="/Users/heoyeeun/Library/Application Support/typora-user-images/스크린샷 2020-06-23 오후 4.26.13.png" alt="스크린샷 2020-06-23 오후 4.26.13" style="zoom:50%;" />



### MVC vs MVVM

#### 차이점

- MVVM은 model이 view controller에 직접 접근이 불가능함.
- MVVM은 View에 UIViewController가 있음 (MVC는 controller에 존재했음.)

 

#### MVVM 개선점

- ViewController의 역할을 축소함으로써 기술 부채를 줄임.
- view에 Controller을 구축함으로써 할일이 명확해지게 만들어줌.  할일이 명확해질 수록 수정이 용이 --> 유지 보수 비용이 줄어듦



### MVVM 실제 구현

- View / View Controller --> view layer에 포함

- view model: 중계자 역할을 수행. ==> view와 view controller와 의사소통 담당. 

- View Model은 Model을 가지고 있음. 

- Model은 view layer와 직접 소통하지 않음. (View Model만 직접 소통 가능.)

  

![스크린샷 2020-06-23 오후 4.34.22](/Users/heoyeeun/Library/Application Support/typora-user-images/스크린샷 2020-06-23 오후 4.34.22.png)





### 리팩터링

- 유지 보수 용이 / 재생 가능 / 기술 부채를 줄이기 위해 코드를 수정하는 과정. 

  

#### 리팩터링 원칙

- 중복 제거
- 단일 책임 갖기 (method 등 수정) --> 10, 200 rule(= 메소드는 10줄 이내, 클래스는 200줄 이내로 짜기)

