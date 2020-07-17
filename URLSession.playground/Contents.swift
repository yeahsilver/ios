import UIKit

//URL
let urlString = "https://itunes.apple.com/search?media=music&entity=song&term=Gdragon"
let url = URL(string: urlString)

url?.absoluteString // 실제 주소
url?.scheme // 현재 http 프로토콜
url?.host // host 주소
url?.path // 하위 주소
url?.query // 쿼리 정보
url?.baseURL // base URL

let baseURL = URL(string: "https://itunes.apple.com")
let relativeURL = URL(string: "search?media=music&entity=song&term=Gdragon", relativeTo: baseURL) // base URL 설정

// 주의: URL은 최대한 서버가 이해할 수 있는 언어로 인코딩해야함! 그래서 한국어를 인식하지 못할 경우가 있음.

relativeURL?.absoluteString // 실제 주소
relativeURL?.scheme // 현재 http 프로토콜
relativeURL?.host // host 주소
relativeURL?.path // 하위 주소
relativeURL?.query // 쿼리 정보
relativeURL?.baseURL //


// URLComponent
var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")
let mediaQuery = URLQueryItem(name: "media", value: "music")
let entityQuery = URLQueryItem(name: "entity", value: "song")
//let termQuery = URLQueryItem(name: "term", value: "Gdragon")
//let termQuery = URLQueryItem(name: "term", value: "지드래곤") // "지드래곤"이 인코딩되서 변환되서 넘어감.
let termQuery = URLQueryItem(name: "term", value: "gdragon hello") // 띄어쓰기도 인코딩을 해주어야함.

urlComponents?.queryItems?.append(mediaQuery)
urlComponents?.queryItems?.append(entityQuery)
urlComponents?.queryItems?.append(termQuery)


urlComponents?.url
urlComponents?.url?.scheme
urlComponents?.string
urlComponents?.queryItems
urlComponents?.queryItems?.last?.value
