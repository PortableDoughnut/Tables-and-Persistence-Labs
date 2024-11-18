
import UIKit

class FurnitureDetailViewController: UIViewController {
    
    var furniture: Furniture?
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
	let imagePicker: UIImagePickerController = .init()
	
    init?(coder: NSCoder, furniture: Furniture?) {
        self.furniture = furniture
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		imagePicker.delegate = self
		
        updateView()
    }
    
    func updateView() {
        guard let furniture = furniture else {return}
        if let imageData = furniture.imageData,
            let image = UIImage(data: imageData) {
            photoImageView.image = image
        } else {
            photoImageView.image = nil
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: UIButton) {
        getPhoto(sender)
    }

    @IBAction func actionButtonTapped(_ sender: UIButton) {
        guard let image = photoImageView.image else {return}
		
		let activityController: UIActivityViewController = .init(activityItems: [image], applicationActivities: nil)
		activityController.popoverPresentationController?.sourceView = sender
		
		present(activityController, animated: true, completion: nil)
    }
    
}

extension FurnitureDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func getPhoto(_ sender: UIButton) {
		let alertController: UIAlertController = .init(title: "Chose image source",
													   message: nil,
													   preferredStyle: .actionSheet)
		
		let cancelAlertAction: UIAlertAction = .init(title: "Cancel", style: .cancel, handler: nil)
		alertController.addAction(cancelAlertAction)
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let cameraAction: UIAlertAction = .init(
				title: "Camera",
				style: .default,
				handler: { [self] action in
					imagePicker.sourceType = .camera
					self.present(imagePicker, animated: true, completion: nil)
				}
			)
			alertController.addAction(cameraAction)
		}
			if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
				let photoLibraryAction: UIAlertAction = .init(
					title: "Photo Library",
					style: .default,
					handler: { [self] action in
						imagePicker.sourceType = .photoLibrary
						self.present(imagePicker, animated: true, completion: nil)
					})
				alertController.addAction(photoLibraryAction)
			}
		
		alertController.popoverPresentationController?.sourceView = sender
		
		present(alertController, animated: true, completion: nil)
		}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let furnitureImage = info[.originalImage] as? UIImage else { return }
		
		furniture?.imageData = furnitureImage.jpegData(compressionQuality: 0.9)
		
		photoImageView.image = furnitureImage
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
	}
