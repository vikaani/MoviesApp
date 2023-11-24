//
//  UserProfileViewController.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {
    @IBOutlet var userEmaiLabel: UILabel!
    @IBOutlet var userImageView: UIImageView!
    
    var onTapSignOutButton: (() -> Void)?
    
    private let userAvatarImageStore: FirebaseUserAvatarImageStore
    
    init(userAvatarImageStore: FirebaseUserAvatarImageStore) {
        self.userAvatarImageStore = userAvatarImageStore
        super.init(nibName: UserProfileViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .signOut, style: .done, target: self, action: #selector(didTapSignOutButton))

        if let user = Auth.auth().currentUser {
            userEmaiLabel.text = user.email
        }
        
        getUserAvatarImage()
    }

    @IBAction private func didSelectUserImage(_ sender: Any) {
        showAlert()
    }

    @objc private func didTapSignOutButton() {
        try? Auth.auth().signOut()
        onTapSignOutButton?()
    }

    private func showImagePicker(Source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(Source) else {
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = Source
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    private func showAlert() {
        let allertController = UIAlertController(title: "Image", message: "Select Image", preferredStyle: .actionSheet)
        
        let cameraButton = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
            self?.showImagePicker(Source: .camera)
        }
        
        let libraryButton = UIAlertAction(title: "Library", style: .default) { [weak self] (_) in
            self?.showImagePicker(Source: .photoLibrary)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        allertController.addAction(cameraButton)
        allertController.addAction(libraryButton)
        allertController.addAction(cancelButton)
        self.present(allertController, animated: true, completion: nil)
    }
    
    private func getUserAvatarImage() {
        userAvatarImageStore.getImageData { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.userImageView.image = UIImage(data: data)
                }
            case .failure(_):
                break
            }
        }
    }
    
}

extension UserProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage  else { return }
        userImageView.image = image
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            userAvatarImageStore.save(imageData: imageData)
        }

        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
