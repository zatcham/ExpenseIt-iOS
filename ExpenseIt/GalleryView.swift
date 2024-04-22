//
//  GalleryView.swift
//  ExpenseIt
//
//  Created by George Clarke on 04/03/2024.
//

import SwiftUI
import PhotosUI
import SwiftyJSON
import Vision

weak var imageview: UIImageView!

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

extension String {
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}

//func chooseImageAction(_ sender: Any){
//    
//}
//
//func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController{
//    let imagePicker = UIImagePickerController()
//    imagePicker.sourceType = sourceType
//    return imagePicker
//}
//
//func showImagePickerOptions(){
//    let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose a picture from library or take picture", preferredStyle: .actionSheet)
//    
////    let cameraAction = UIAlertAction(title: "Camera", style: .default){
////        let cameraImagePicker = imagePicker(sourceType: .camera)
////    }
//    
//}

func doSendImage(img: Image?, requestId: String) {
    
    
}

struct GalleryView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var requestId: String = "7"
    weak var imageview: UIImageView!
    
    
    var body: some View {
        if #available(iOS 17.0, *) {
            VStack {
                PhotosPicker("Select a reciept", selection: $pickerItem, matching: .images)
                selectedImage?
                    .resizable()
                    .scaledToFit()
                Button(
                    action: {
                        doSendImage(img: selectedImage, requestId: requestId)
                    }, label: {
                        Text("Send Image")
                    })
                
                
            }
            .onChange(of: pickerItem) {
                Task {
                    selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
                    
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

