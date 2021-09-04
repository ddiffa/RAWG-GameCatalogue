//
//  ImagePicker.swift
//  RAWG-GameCatalogue
//
//  Created by Diffa Desyawan on 04/09/21.
//

import UIKit
import MobileCoreServices

protocol ImagePickerDelegate: AnyObject {
    func imagePicker(present imagePicker: UIImagePickerController)
    func imagePicker(present alert: UIAlertController)
    func imagePicker(didFinishPickingMedia selectedImage: UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate,
                   UINavigationControllerDelegate {
    
    weak var delegate: ImagePickerDelegate?
    
    func show() {
        let imagePickerActionSheet = UIAlertController(title: "Change Image",
                                                       message: nil,
                                                       preferredStyle: .actionSheet)
        
        let libraryButton = UIAlertAction(
            title: "Choose From Photos",
            style: .default) { (_) -> Void in
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = [kUTTypeImage as String]
            self.delegate?.imagePicker(present: imagePicker)
        }
        
        imagePickerActionSheet.addAction(libraryButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        self.delegate?.imagePicker(present: imagePickerActionSheet)
    }
}

extension ImagePicker {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedPhoto = info[.editedImage] as? UIImage else {
            return
        }
        
        self.delegate?.imagePicker(didFinishPickingMedia: selectedPhoto)
    }
}
