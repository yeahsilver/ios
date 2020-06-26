## Collection View

: 한 행 안에 여러개의 데이터가 들어있는 것.

<img width="228" alt="스크린샷 2020-06-25 오후 9 06 04" src="https://user-images.githubusercontent.com/39258902/85716682-afd80980-b727-11ea-943d-0cb2b33f2739.png">

- 수평 / 수직 방향을 정할 수 있음.



### UICollectionViewLayout

- Collection view를 상속받음
- datasource & delegate 사용 --> protocol
- protocol: 어떤 서비스를 이용하기 위해 해야 할 일.



#### UICollectionViewFlowLayout





## Animation

: 시간에 따라, 뷰의 상태가 바뀌는 것.

- animation = 시작, 끝, 시간.

  

#### Animation API

```swift
UIView.animate(
	withDuration: 1.0
	animations: {
		layoutIfNeeded()
	}
)
```

