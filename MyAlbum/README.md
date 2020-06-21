## Object

- data
  - 타이틀 / 메시지 등이 작동되는 것
- method
  - object에 속해서 기능을 수행하는 것

예시) 파티 호스트의 역할: 파티 준비 

object: 파티 호스트 / data: 참석자 주소 / method: 파티 준비

파티 참석자의 역할: 파티 참여

object: 파티 참석자 / data: 파티의 주소지 method: 파티 즐기기. 



##  String & Variable

- string

  - 문자열의 나열 

  - "Hello \\(변수)" 형태로 사용.

  - let message = "가격은 ₩\\(currentValue)입니다."

  - let randomPrice = arc4random_uniform(10000)+1

    currentValue = Int(randomPrice)

- variable

  - 컴퓨터 안에서 값을 저장한 공간

  - type 

    - 정수형 / 문자열 --> 타입이 다름. ==> 다른 타입을 준비해야함

    - Ex) 빈  오피스텔 룸 = nil, 오피스텔에 입주자가 생기면 오피스텔 룸 = 사람

      이때 오피스텔 룸이 변수이고, 사람이 값.



## Variable vs Constant

- var ( = variable)
  - 값이 바뀔 수 있음
- let ( = constant)
  - 값을 바꿀 수 없음

==> constant를 많이 사용하는 것을 추천!



## Local vs Instance

- local 
  - 메소드 안에서만 사용되는 변수
- instance
  - object 내부에서 전반적으로 사용되는 변수



## Closure

- closure = {}
  - 실행 가능한 코드 블럭. (변수처럼 사용)



## Styling

- Image

  - 크기가 1x / 2x / 3x로 나뉨. 
  - @2x 이런식으로 표기!

  
