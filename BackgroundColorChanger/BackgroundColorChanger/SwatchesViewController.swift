//
//  SwatchesViewController.swift
//  ClassConstraints
//
//  Created by Christopher Boyd on 10/26/20.
//

import UIKit

final class SwatchesViewController: UICollectionViewController {
    private let reuseIdentifier = "SwatchCell";
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
    private let itemsPerRow: CGFloat = 3
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadView()
    }
}

extension SwatchesViewController {
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return StorageHandler.storageCount()
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {

    // Get the corresponding color
    let cellColorsArray = ColorManager.colorCollection
    let cellColorArray = cellColorsArray[indexPath.item]
    let cellColor = UIColor(red: CGFloat(cellColorArray.red)/255, green: CGFloat(cellColorArray.green)/255, blue: CGFloat(cellColorArray.blue)/255, alpha: CGFloat(cellColorArray.alpha)/255)
    
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    cell.backgroundColor = cellColor
    
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureDetected))
    longPressGesture.minimumPressDuration = 0.5
    longPressGesture.delaysTouchesBegan = true
    cell.addGestureRecognizer(longPressGesture)
    
    return cell
  }
    
    @objc func longPressGestureDetected(_ gestureRecognizer: UILongPressGestureRecognizer) {
        //we will want to make sure the following code only happens when the long press gesture BEGINS
        if (gestureRecognizer.state == .began) {
            let point = gestureRecognizer.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: point) {
                //do stuff with cell for ex. print the indexPath
                print(indexPath.row)
            }
            else{
                print("could not find path")
            }
        }
    }
}

extension SwatchesViewController : UICollectionViewDelegateFlowLayout {
    
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

extension SwatchesViewController {
  override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    let cellColorsArray = ColorManager.colorCollection
    let cellColorArray = cellColorsArray[indexPath.item]
    let colorTab = tabBarController!.viewControllers![0] as! ViewController

    colorTab.sliderR.value = Float(cellColorArray.red)
    colorTab.sliderG.value = Float(cellColorArray.green)
    colorTab.sliderB.value = Float(cellColorArray.blue)
    colorTab.sliderA.value = Float(cellColorArray.alpha)
    colorTab.adjustSlider(self)

    self.tabBarController!.selectedIndex = 0

    return false
  }
}
