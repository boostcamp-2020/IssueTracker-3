# IssueTracker iOS app 
[![Releases](https://img.shields.io/github/v/release/boostcamp-2020/IssueTracker-3)](https://github.com/boostcamp-2020/IssueTracker-3/releases)
[![build](https://github.com/boostcamp-2020/IssueTracker-3/workflows/iOS%20CI/badge.svg)](https://github.com/boostcamp-2020/IssueTracker-3/actions)


## 화면 구성
![001](./Image/이미지.001.jpeg)
![002](./Image/이미지.002.jpeg)
![003](./Image/이미지.003.jpeg)
![004](./Image/이미지.004.jpeg)

## Architecture
- VIP
- [Clean Swift](https://clean-swift.com/) 적용

## View
- CollectionView
   - Diffable DataSource
   - Compositional Layout
   - Flow Layout
- TableView

## Network
- `NetworkService`객체 & `NetworkServiceProvider`Protocol
- URLSession 사용
- [Code 보러가기](https://github.com/boostcamp-2020/IssueTracker-3/tree/master/iOS/IssueTracker/IssueTracker/Network)

## Requirements

 - iOS 14.0+
 - Xcode 12.1+
 - Swift 5.3+
 
## Cocoapods

```ruby
target 'IssueTracker' do

  pod 'SwiftLint'

end
```
## Installation

```
$ pod install
```


## Author

- 박재현 [@wogus3602](https://github.com/wogus3602)
- 송민관 [@Minkwan-Song](https://github.com/Minkwan-Song)


## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 
