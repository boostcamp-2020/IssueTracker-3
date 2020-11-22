# IssueTracker iOS app 
[![Releases](https://img.shields.io/github/v/release/boostcamp-2020/IssueTracker-3)](https://github.com/boostcamp-2020/IssueTracker-3/releases)
[![build](https://github.com/boostcamp-2020/IssueTracker-3/workflows/iOS%20CI/badge.svg)](https://github.com/boostcamp-2020/IssueTracker-3/actions)

## 디렉토리 구조
<details>
  <summary>파일 구조 :file_cabinet: </summary>
    <div markdown=“1”>
      <pre>
IssueTracker  
├── Common  
│  ├── Extension  
│  │  ├── Data+decoded.swift  
│  │  ├── Date+timeAgoDisplay.swift  
│  │  ├── DateFormatter+format.swift  
│  │  ├── Encodable+encoded.swift  
│  │  ├── String+asURL.swift  
│  │  ├── String+toDate.swift  
│  │  ├── UIColor+hex.swift  
│  │  ├── UIColor+hexString.swift  
│  │  ├── UIColor+random.swift  
│  │  ├── UIColor+visibleTextColor.swift  
│  │  ├── UIVIew+snapshot.swift  
│  │  ├── UIView+IBInspectable.swift  
│  │  ├── UIView+shake.swift  
│  │  ├── UIViewController+hideKeyboardWhenTapped.swift  
│  │  └── URL+searchToken.swift  
│  ├── KeychainAccess.swift  
│  ├── PropertyWrapper  
│  │  ├── KeyChain.swift  
│  │  └── UserDefault.swift  
│  └── Views  
│    ├── CustomAlertController.storyboard  
│    ├── CustomAlertView.swift  
│    └── CustomButtonView.swift  
├── CreateIssue  
│  ├── CreateIssueInteractor.swift  
│  ├── CreateIssueViewController.swift  
│  └── Models  
│    └── CreateIssueEndPoint.swift  
├── Edit  
│  ├── EditInteractor.swift  
│  ├── EditPresenter.swift  
│  ├── EditViewController.swift  
│  ├── Models  
│  │  ├── IssueDetailEditEndPoint.swift  
│  │  └── IssueDetailEditViewModel.swift  
│  └── Views  
│    └── EditTableViewCell.swift  
├── Entity  
│  ├── AllGetUser.swift  
│  ├── Assignee.swift  
│  ├── Comment.swift  
│  ├── Issue.swift  
│  ├── IssueComment.swift  
│  ├── Label.swift  
│  ├── Milestone.swift  
│  ├── User.swift  
│  └── UserInfo.swift  
├── Info.plist  
├── IssueDetail  
│  ├── Edit  
│  │  └── EditTableViewController.swift  
│  ├── IssueCommentViewController.swift  
│  ├── IssueDetailBottomSheetViewController.swift  
│  ├── IssueDetailInteractor.swift  
│  ├── IssueDetailPresenter.swift  
│  ├── IssueDetailViewController.swift  
│  ├── Models  
│  │  ├── IssueDetailEndPoint.swift  
│  │  └── IssueDetailViewModel.swift  
│  └── Views  
│    ├── IssueDetailCollectionReusableView.swift  
│    └── IssueDetailCollectionViewCell.swift  
├── IssueFilter  
│  ├── IssueFilterViewController.swift  
│  ├── Models  
│  │  └── IssueFilterViewModel.swift  
│  └── Views  
│    ├── HeaderView.swift  
│    └── IssueFilterTableViewCell.swift  
├── IssueList  
│  ├── IssueListEndPoint.swift  
│  ├── IssueListInteractor.swift  
│  ├── IssueListPresenter.swift  
│  ├── IssueListViewController.swift  
│  ├── Models  
│  │  ├── IssueListModelController.swift  
│  │  └── IssueListViewModel.swift  
│  └── Views  
│    └── IssueListCollectionViewCell.swift  
├── IssueTracker  
│  └── Base.lproj  
│    ├── Authentication.storyboard  
│    └── IssueList.storyboard  
├── IssueTracker.entitlements  
├── Label  
│  ├── Label.storyboard  
│  ├── LabelInteractor.swift  
│  ├── LabelPresenter.swift  
│  ├── LabelViewController.swift  
│  ├── Models  
│  │  ├── LabelEndPoint.swift  
│  │  └── LabelViewModel.swift  
│  └── Views  
│    └── LabelCollectionViewCell.swift  
├── Milestone  
│  ├── Base.lproj  
│  │  └── MileStone.storyboard  
│  ├── MilestoneInterator.swift  
│  ├── MilestonePresenter.swift  
│  ├── MilestoneViewController.swift  
│  ├── Models  
│  │  ├── MilestoneCalculator.swift  
│  │  ├── MilestoneEndPoint.swift  
│  │  └── MilestoneViewModel.swift  
│  └── Views  
│    └── MilestoneCollectionViewCell.swift  
├── Network  
│  ├── APIConfiguration.swift  
│  ├── APIServer.swift  
│  ├── ContentType.swift  
│  ├── HTTPHeader.swift  
│  ├── HTTPMethod.swift  
│  ├── NetworkError.swift  
│  └── NetworkService.swift  
├── SceneDelegate.swift  
├── Setting  
│  ├── Setting.storyboard  
│  └── SettingViewController.swift  
├── SignIn  
│  ├── KeychainItem.swift  
│  ├── Models  
│  │  ├── AppleModel.swift  
│  │  ├── AppleUser.swift  
│  │  ├── RequestLogin.swift  
│  │  └── SignInEndPoint.swift  
│  ├── OAuthManager.swift  
│  ├── SignInViewController.swift  
│  └── Views  
│    └── SignInWithAppleButton.swift  
└── SignUp  
└── SignUpViewController.swift
         </pre>
    </div>
</details>

## 화면 구성
![001](./Image/이미지.001.jpeg)
![002](./Image/이미지.002.jpeg)
![003](./Image/이미지.003.jpeg)
![004](./Image/이미지.004.jpeg)

## Architecture
- VIP
- [Clean Swift](https://clean-swift.com/) 적용


![diagram](./Image/diagram.jpg)

## View
| Scene | View | DataSource | Layout | Cell |
|:-:|:-:|:-:|:-:|:-:|
| IssueList | CollectionView | DiffableDataSource | CompositionalLayout | CollectionViewListCell |
| IssueDetail | CollectionView | DiffableDataSource | FlowLayout | CollectionViewCell |
| Label | CollectionView | DiffableDataSource | FlowLayout | CollectionViewCell |
| Milestone | CollectionView | DiffableDataSource | FlowLayout | CollectionViewCell |
| Filter | TableView | DiffableDataSource | X | TableViewCell |

## Network
- `NetworkService`객체 & `NetworkServiceProvider`Protocol
- URLSession 사용
- [Code 보러가기](https://github.com/boostcamp-2020/IssueTracker-3/tree/master/iOS/IssueTracker/IssueTracker/Network)

## Authentication
- github OAuth
- Sign in with Apple
- 회원가입
- 로그인
- 서버에서 받은 JWT를 KeyChain을 사용하여 안전하게 저장
   - Property Wrapper 사용
   - 참고자료 : [KeyChain](https://medium.com/@justfaceit/ios-%EC%95%B1-%EB%B6%80%ED%92%88-%EB%A7%8C%EB%93%A4%EA%B8%B0-1-preferencestorage-%EC%84%A4%EC%A0%95-%EC%A0%80%EC%9E%A5%EC%9D%84-%EC%9C%84%ED%95%9C-%EA%B3%B5%ED%86%B5-%ED%81%B4%EB%9E%98%EC%8A%A4-2eb2c27af941)
   
## Unit Test
#### IssueList
- IssueListEndPointTest
- IssueListViewModelTest
- ViewControllerTest
- InteractorTest
- IssueListFilterTests
- IssueListMakeTests

#### Test Doubles
- NetworkServiceMock
- IssueListBusinessLogicSpy
- CollectionViewDiffableDataSourceSpy
- IssueListPresentationLogicSpy
- IssuesMock

## Library
- [MarkdownView](https://github.com/keitaoouchi/MarkdownView)
- [SwiftyMarkdown](https://github.com/SimonFairbairn/SwiftyMarkdown)

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
