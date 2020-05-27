//
//  ParticipanteViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 05/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData



class ParticipanteViewController: UIViewController, ImagePickerFotoSelecionada {

    @IBOutlet weak var viewImageParticipante: UIView!
    @IBOutlet weak var ImageParticipante: UIImageView!
    @IBOutlet weak var buttonFoto: UIButton!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    
    @IBOutlet weak var textNome: UITextField!
    @IBOutlet weak var textTelefone: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textDataNascimento: UITextField!
    
    let imagePicker = ImagePicker()
    var participanteSelecionado : [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        CriaTollBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScroll), name: UIResponder.keyboardWillShowNotification, object: nil)
       
        PreencheCamposAlteracaoParticipante()
        
   }
    
    // MARK: - Métodos
    
    func setup() {
        imagePicker.delegate = self
    }
    
    @objc func aumentarScroll (notification: Notification) {
       self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + 320)
   }
    
    func mostrarMultimidia(_ opcao:MenuOpcoes) {
        let multimidia = UIImagePickerController()
        multimidia.delegate = imagePicker
        
        if opcao == .camera && UIImagePickerController.isSourceTypeAvailable(.camera) {
            multimidia.sourceType = .camera
        }
        else {
            multimidia.sourceType = .photoLibrary
        }
        self.present(multimidia, animated: true, completion: nil)
    }

    // MARK: - Delegate
    func imagePickerFotoSelecionada(_ foto: UIImage) {
        ImageParticipante.image = foto
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func buttonFoto(_ sender: Any) {
                let menu = ImagePicker().menuDeOpcoes { (opcao) in
                    self.mostrarMultimidia(opcao)
                }
                present(menu, animated: true, completion: nil)
    }
    
    
    @IBAction func adicionaParticipante(_ sender: Any) {
        
        if participanteSelecionado.count > 0 {
            alteraParticipante()
        }
        else {
            addParticipante()
            
        }
    }
    
    
    func PreencheCamposAlteracaoParticipante () {
        if participanteSelecionado.count > 0 {

            guard let nome = participanteSelecionado[0].value(forKey: "nome") else {return}
            guard let telefone = participanteSelecionado[0].value(forKey: "telefone") else {return}
            guard let email = participanteSelecionado[0].value(forKey: "email") else {return}
            guard let dataNascimento = participanteSelecionado[0].value(forKey: "data_nascimento") else {return}
            guard let foto = participanteSelecionado[0].value(forKey: "foto") else {return}
           
            
            textNome.text = nome as? String
            textTelefone.text = telefone as? String
            textEmail.text = email as? String
            textDataNascimento.text = dataNascimento as? String
            ImageParticipante.image = UIImage(data: foto as! Data)
            
        }
    }
    
    func addParticipante () {
          //variaveis de conexao com coreData
          let appDelegate = UIApplication.shared.delegate as? AppDelegate
          let context = appDelegate?.persistentContainer.viewContext
          let conectBD = NSEntityDescription.insertNewObject(forEntityName: "ParticipantesDB", into: context!)
      
          if validaCadastro() == true {
              
              guard let nome = textNome.text else {return}
              guard let dataNascimento = textDataNascimento.text else {return}
              guard let telefone = textTelefone.text else {return}
              guard let email = textEmail.text else {return}
              
              let data = self.ImageParticipante.image?.pngData() as NSData?
              
              conectBD.setValue(nome, forKey: "nome")
              conectBD.setValue(dataNascimento, forKey: "data_nascimento")
              conectBD.setValue(telefone, forKey: "telefone")
              conectBD.setValue(email, forKey: "email")
              conectBD.setValue(data, forKey: "foto")
              
              do {
                  try context?.save()
                  //vai para telas de favoritos
                  TelaPrincipal()
                 } catch  {
                     print("Erro ao Salvar Favorito")
                 }
              
          }
      }
    
    func alteraParticipante () {
           let appDelegate = UIApplication.shared.delegate as? AppDelegate
           //let context = appDelegate?.persistentContainer.viewContext
           let context = appDelegate!.persistentContainer.viewContext
           let entitidec = NSEntityDescription.entity(forEntityName: "ParticipantesDB", in: context)
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ParticipantesDB")
           request.entity = entitidec
           let pred = NSPredicate(format: "nome =%@", textNome.text!)
           request.predicate = pred
           
           do {
               let result =  try context.fetch(request)
               if result.count > 0 {
                    let manage = result[0] as! NSManagedObject

                    manage.setValue(textNome.text, forKey: "nome")
                    manage.setValue(textTelefone.text, forKey: "telefone")
                    manage.setValue(textDataNascimento.text, forKey: "data_nascimento")
                    manage.setValue(textEmail.text,forKey: "email")

                    let data = self.ImageParticipante.image?.pngData() as NSData?
                    manage.setValue(data, forKey: "foto")

                    try context.save()
                    TelaPrincipal()
               }
           } catch  let erro1 as NSError{
               print (erro1)
           }
           catch  {
                   print ("Erro")
           }
       }
        
    @IBAction func FocoDataNascimento(_ sender: UITextField) {
        let datePickerHorario : UIDatePicker = UIDatePicker()
        //Configura DatePicker
        let config = configuracao()
        sender.inputView =  config.configuraDatePicker(datePickerHorario)
        datePickerHorario.addTarget(self, action: #selector(exibeData(sender:)), for: .valueChanged)
    }
    
    @objc func exibeData (sender: UIDatePicker) {
           let formatador = DateFormatter()
           formatador.dateFormat = "dd/MM/yyyy"
           self.textDataNascimento.text = formatador.string(from: sender.date)
       }
    
  
    
    func TelaPrincipal() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validaCadastro () -> Bool {
           var valida : Bool = true
           
                    if textNome.text!.isEmpty {
                        exibeMensagemAlerta (titulo: "Dado Invalido.", mensagem: "Preencha o Nome do Participante.")
                        valida = false
                    }
                    
                    if textDataNascimento.text!.isEmpty {
                         exibeMensagemAlerta (titulo: "Dado Invalido.", mensagem: "Preencha a Data de Nascimento.")
                         valida = false
                     }

           
           return valida
       }
    
    func exibeMensagemAlerta (titulo: String, mensagem:String){
          let myAlert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
          let oKAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
          myAlert.addAction(oKAction)
          self.present(myAlert, animated: true, completion: nil)
      }
    
    @IBAction func doneNome(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneTelefone(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneEmail(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func addDoneButtonOnKeyboard() {
           let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
           doneToolbar.barStyle       = UIBarStyle.default
           let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(CadastroCelulaViewController.doneButtonAction))

           var items = [UIBarButtonItem]()
           items.append(flexSpace)
           items.append(done)

           doneToolbar.items = items
           doneToolbar.sizeToFit()

        self.textTelefone.inputAccessoryView = doneToolbar
        self.textNome.inputAccessoryView = doneToolbar
        self.textEmail.inputAccessoryView = doneToolbar
        self.textDataNascimento.inputAccessoryView = doneToolbar
        
           
       }

       @objc func doneButtonAction() {
            self.textTelefone.resignFirstResponder()
            self.textDataNascimento.resignFirstResponder()
            self.textEmail.resignFirstResponder()
            self.textNome.resignFirstResponder()
       }
    
     func CriaTollBar () {
         let toolBar = UIToolbar()
         toolBar.sizeToFit()
         let botaoOk = UIBarButtonItem(title: "OK", style: .done, target: self, action:#selector(self.dismissKeyboard))
         toolBar.setItems([botaoOk], animated: false)
         toolBar.isUserInteractionEnabled = true
         textDataNascimento.inputAccessoryView = toolBar
         
         let toolbarDone = UIToolbar.init()
         toolbarDone.sizeToFit()
    
         addDoneButtonOnKeyboard()
     }
     
     @objc func dismissKeyboard() {
         self.view.endEditing(true)
     }
       
    
}
