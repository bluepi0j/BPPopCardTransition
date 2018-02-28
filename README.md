# BPPopCardTransition

[![CI Status](http://img.shields.io/travis/bluepi0j/BPPopCardTransition.svg?style=flat)](https://travis-ci.org/bluepi0j/BPPopCardTransition)
[![Version](https://img.shields.io/cocoapods/v/BPPopCardTransition.svg?style=flat)](http://cocoapods.org/pods/BPPopCardTransition)
[![License](https://img.shields.io/cocoapods/l/BPPopCardTransition.svg?style=flat)](http://cocoapods.org/pods/BPPopCardTransition)
[![Platform](https://img.shields.io/cocoapods/p/BPPopCardTransition.svg?style=flat)](http://cocoapods.org/pods/BPPopCardTransition)
![Swift 4](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)

## Overview


![Overview](https://raw.githubusercontent.com/bluepi0j/BPPopCardTransition/master/Images/example1.GIF)

![Overview](https://raw.githubusercontent.com/bluepi0j/BPPopCardTransition/master/Images/example2.GIF)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

BPPopCardTransition is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BPPopCardTransition"
```
## Usage

Add BPPopCardAnimtionDelegate

```swift
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, BPPopCardAnimtionDelegate
```

```swift
let transitionDelegate:BPPopCardTransitionsDelegate = BPPopCardTransitionsDelegate()
```

```swift
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let cell: ImageCollectionViewCell = collectionView.cellForItem(at: indexPath)! as! ImageCollectionViewCell

    selectedCellFrame = collectionView.convert(cell.frame, to: self.view)
    selectedCellImageView = cell.cellImageView


    let popCardViewController: PopCardViewController = self.storyboard?.instantiateViewController(withIdentifier: "PopCardViewController") as! PopCardViewController

    transitionDelegate.delegate = self

    popCardViewController.transitioningDelegate = transitionDelegate
    popCardViewController.bannerImage = self.selectedCellImageView!.image
    popCardViewController.modalPresentationStyle = .custom
    self.present(popCardViewController, animated: true, completion: nil)

}
```
```swift

// MARK: - BPPopCardAnimtionDelegate
func rectZoomPosition() -> CGRect {
    return selectedCellFrame!
}

func cellImageView() -> UIImageView {
    return selectedCellImageView!
}

func popCardViewBannerHeight() -> CGFloat {
    return CGFloat(267)
}
```


## TODO

- [ ] Make more generic.

## Author

bluepi0j, bluepi0j@gmail.com

## License

BPPopCardTransition is available under the MIT license. See the LICENSE file for more info.


