//
//  ImagePicker.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 05/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit

enum MenuOpcoes {
    case camera
    case biblioteca
}

protocol ImagePickerFotoSelecionada {
    func imagePickerFotoSelecionada(_ foto:UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Atributos
    
    var delegate:ImagePickerFotoSelecionada?
    
    // MARK: - Métodos
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let foto = info[.originalImage] as! UIImage
        delegate?.imagePickerFotoSelecionada(foto)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func menuDeOpcoes(completion:@escaping(_ opcao:MenuOpcoes) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "escolha uma das opções abaixo", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "tirar foto", style: .default) { (acao) in
            completion(.camera)
        }
        menu.addAction(camera)
        
        let biblioteca = UIAlertAction(title: "biblioteca", style: .default) { (acao) in
            completion(.biblioteca)
        }
        menu.addAction(biblioteca)
        
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        
        return menu
    }
}


