
import UIKit

class FurnitureDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var furniture: Furniture?
    var imagePicker: UIImagePickerController!
    
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        guard let furniture = furniture else {return}
        if let imageData = furniture.imageData,
            let image = UIImage(data: imageData) {
            choosePhotoButton.setTitle("", for: .normal)
            choosePhotoButton.setImage(image, for: .normal)
        } else {
            choosePhotoButton.setTitle("Choose Image", for: .normal)
            choosePhotoButton.setImage(nil, for: .normal)
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
                
            })
            actionSheet.addAction(photoLibraryAction)
        }
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
                
            })
            actionSheet.addAction(cameraAction)
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        print("actionButtonTapped!!!!")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imagePickerController!!!!")
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage {
            
            self.furniture = furniture(title: "test", description: "test", imageData: pickedImage.pngData())
            
            updateView()

        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel!!!!")
        dismiss(animated: true, completion: nil)
    }
    
}
