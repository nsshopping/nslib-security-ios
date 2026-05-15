# nslib-security-ios

nslib-security-ios는 루팅된 기기를 감지하기 위한 Swift 라이브러리입니다. 이 라이브러리는 쉽게 사용할 수 있도록 설계되었으며, 다양한 보안 기능을 제공합니다.

## 설치

### Swift Package Manager

nslib-security-ios는 Swift Package Manager(SPM)를 통해 설치할 수 있습니다. `Package.swift` 파일에 다음과 같이 추가하세요:

```swift
dependencies: [
    .package(url: "https://github.com/nsshopping/nslib-security-ios.git", from: "1.0.0")
]
```

### CocoaPods

`Podfile`에 다음을 추가하세요:

```ruby
platform :ios, '13.0'

target 'YourAppTarget' do
  use_frameworks!
  pod 'nslib-security-ios', :git => 'https://github.com/nsshopping/nslib-security-ios.git', :tag => '1.0.0'
end
```

그리고 아래 명령을 실행합니다:

```bash
pod install
```

## 배포 메모 (CocoaPods)

공개 배포를 하려면 새 버전 태그를 만든 뒤 podspec lint/push를 수행합니다.

```bash
pod spec lint nslib-security-ios.podspec --allow-warnings
pod trunk push nslib-security-ios.podspec --allow-warnings
```
