//
//  CadastroCelulaViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 27/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class CadastroCelulaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var textNomeCelula: UITextField!
    @IBOutlet weak var textNomeLider: UITextField!
    @IBOutlet weak var textNomeAnfitriao: UITextField!
    @IBOutlet weak var textDia: UITextField!
    @IBOutlet weak var textHorario: UITextField!
    
    @IBOutlet weak var textCep: UITextField!
    @IBOutlet weak var textLogradouro: UITextField!
    @IBOutlet weak var textBairro: UITextField!
    @IBOutlet weak var textMunicipio: UITextField!
    @IBOutlet weak var textUF: UITextField!
    @IBOutlet weak var textNumero: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var activitIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let pickerViewDia: UIPickerView = UIPickerView()
    let dias = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sabado", "Domingo"]
    
    let celulaObject = FormataCelula()
     var celulaSelecionada : [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewDia.delegate = self
        pickerViewDia.dataSource = self
        textDia.inputView = pickerViewDia
        CriaTollBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScroll), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        PreencheCamposAlteracaoCelula()

    }
    
    
    func PreencheCamposAlteracaoCelula () {
        if celulaSelecionada.count > 0 {

            guard let nomeCelula = celulaSelecionada[0].value(forKey: "nome") else {return}
            guard let nomeLider = celulaSelecionada[0].value(forKey: "lider") else {return}
            guard let nomeAnf = celulaSelecionada[0].value(forKey: "anfitriao") else {return}
            guard let dia = celulaSelecionada[0].value(forKey: "dia") else {return}
            guard let horario = celulaSelecionada[0].value(forKey: "horario") else {return}
            guard let cep = celulaSelecionada[0].value(forKey: "cep") else {return}
            guard let logadouro = celulaSelecionada[0].value(forKey: "logradouro") else {return}
            guard let numero = celulaSelecionada[0].value(forKey: "numero") else {return}
            guard let bairro = celulaSelecionada[0].value(forKey: "bairro") else {return}
            guard let municipio = celulaSelecionada[0].value(forKey: "municipio") else {return}
            guard let uf = celulaSelecionada[0].value(forKey: "uf") else {return}
            
            textNomeCelula.text = nomeCelula as? String
            textNomeLider.text = nomeLider as? String
            textNomeAnfitriao.text = nomeAnf as? String
            textDia.text = dia as? String
            textHorario.text = horario as? String
            textCep.text = cep as? String
            textLogradouro.text = logadouro as? String
            textNumero.text = numero as? String
            textBairro.text = bairro as? String
            textMunicipio.text = municipio as? String
            textUF.text = uf as? String
            
        }
    }
    
    
    @objc func aumentarScroll (notification: Notification) {
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height + 320)
    }
    
    @IBAction func ActivitIndicator(_ sender: UITextField) {
        activitIndicator.center = self.textCep.center
        activitIndicator.hidesWhenStopped = true
        textCep.addSubview(activitIndicator)
        activitIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
  
    }
    
    
    
    @IBAction func adicionarCelula(_ sender: Any) {
        
        if celulaSelecionada.count > 0 {
            alteraCelula()
        } else {
            guard let nome = self.textNomeCelula.text else {return}
            if celulaObject.verificaCelulaExiste(nome) == false {
                addCelula()
            }else {
                    exibeMensagemAlerta(titulo: nome, mensagem: "Este nome de celula já existe. Digite um nome diferente.")
                }
            }
    }
    
    func CriaTollBar () {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let botaoOk = UIBarButtonItem(title: "OK", style: .done, target: self, action:#selector(self.dismissKeyboard))
        toolBar.setItems([botaoOk], animated: false)
        toolBar.isUserInteractionEnabled = true
        textDia.inputAccessoryView = toolBar
        textHorario.inputAccessoryView = toolBar
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
   
        addDoneButtonOnKeyboard()
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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

        self.textCep.inputAccessoryView = doneToolbar
        self.textNumero.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.textCep.resignFirstResponder()
        self.textNumero.resignFirstResponder()
    }
    
    func alteraCelula () {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        //let context = appDelegate?.persistentContainer.viewContext
        let context = appDelegate!.persistentContainer.viewContext
        let entitidec = NSEntityDescription.entity(forEntityName: "CelulaDB", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CelulaDB")
        request.entity = entitidec
        let pred = NSPredicate(format: "nome =%@", textNomeCelula.text!)
        request.predicate = pred
        
        do {
            let result =  try context.fetch(request)
            if result.count > 0 {
                let manage = result[0] as! NSManagedObject
    
                manage.setValue(textNomeCelula.text!, forKey: "nome")
                manage.setValue(textNomeLider.text, forKey: "lider")
                manage.setValue(textNomeAnfitriao.text, forKey: "anfitriao")
                manage.setValue(textDia.text,forKey: "dia")
                manage.setValue(textHorario.text, forKey: "horario")
                manage.setValue(textCep.text, forKey: "cep")
                manage.setValue(textLogradouro.text, forKey: "logradouro")
                manage.setValue(textNumero.text, forKey: "numero")
                manage.setValue(textBairro.text, forKey: "bairro")
                manage.setValue(textMunicipio.text, forKey: "municipio")
                manage.setValue(textUF.text, forKey: "uf")

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
    
    
    func addCelula () {
        //variaveis de conexao com coreData
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let conectBD = NSEntityDescription.insertNewObject(forEntityName: "CelulaDB", into: context!)
        
        if validaCadastro() == true {
            guard let nomeCelula = textNomeCelula.text else {return}
            guard let nomeLider = textNomeLider.text else {return}
            guard let nomeAnf = textNomeAnfitriao.text else {return}
            guard let dia = textDia.text else {return}
            guard let horario = textHorario.text else {return}
            guard let cep = textCep.text else {return}
            guard let logadouro = textLogradouro.text else {return}
            guard let numero = textNumero.text else {return}
            guard let bairro = textBairro.text else {return}
            guard let municipio = textMunicipio.text else {return}
            guard let uf = textUF.text else {return}
            
            conectBD.setValue(nomeCelula, forKey: "nome")
            conectBD.setValue(nomeLider, forKey: "lider")
            conectBD.setValue(nomeAnf, forKey: "anfitriao")
            conectBD.setValue(dia, forKey: "dia")
            conectBD.setValue(horario, forKey: "horario")
            conectBD.setValue(cep, forKey: "cep")
            conectBD.setValue(logadouro, forKey: "logradouro")
            conectBD.setValue(numero, forKey: "numero")
            conectBD.setValue(bairro, forKey: "bairro")
            conectBD.setValue(municipio, forKey: "municipio")
            conectBD.setValue(uf, forKey: "uf")
            
            do {
                try context?.save()
                print ("Celula incluida com sucesso.")
                //vai para telas de favoritos
                TelaPrincipal()
               } catch  {
                   print("Erro ao Salvar Favorito")
               }
        }
    }
    
    
    @IBAction func chamaBuscaCep(_ sender: Any) {
        getCep()
    }
    
    func getCep () {
        guard let cep = self.textCep.text else {return}
        var dic: NSDictionary = [:]
            
        BuscaCep.BuscaCep(cep, onComplete: { (cepDicionario) in
            
            dic = cepDicionario
            
            if dic.count > 1 {
                self.preencheDados(dic)
            }else {
                self.preencheDados(nil)
            }
            
        }) { (error) in
            print (error)
        }
        
       activitIndicator.stopAnimating()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.dias.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = self.dias[row]
       return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textDia.text = self.dias[row]
    }
    

    @IBAction func entraFocoDia(_ sender: Any) {
        self.textDia.text = "Segunda"
    }
    
  
    
    @IBAction func entraFocoHorario(_ sender: UITextField) {
        
        self.textHorario.text = getCurrentShortDate()
        
       let datePickerHorario : UIDatePicker = UIDatePicker()
        datePickerHorario.datePickerMode = .time
        datePickerHorario.locale = Locale(identifier: "br")
    
        sender.inputView = datePickerHorario
        datePickerHorario.addTarget(self, action: #selector(exibeData(sender:)), for: .valueChanged)
        
    }
    
    @objc func exibeData (sender: UIDatePicker) {
        let formatador = DateFormatter()
        formatador.dateFormat = "HH:mm"
        formatador.timeZone = .current
        formatador.locale = .current
        self.textHorario.text = formatador.string(from: sender.date)
    }
    
    func getCurrentShortDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "HH:mm"
        let DateInFormat = dateFormatter.string(from: todaysDate)

         return DateInFormat
     }
    
    func exibeMensagemAlerta (titulo: String, mensagem:String){
        let myAlert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let oKAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(oKAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func validaCadastro () -> Bool {
        var valida : Bool = true
        
                 if textNomeCelula.text!.isEmpty {
                     exibeMensagemAlerta (titulo: "Dado Invalido.", mensagem: "Preencha o Nome da Celula.")
                     valida = false
                 }
                 
                 if textNomeLider.text!.isEmpty {
                      exibeMensagemAlerta (titulo: "Dado Invalido.", mensagem: "Preencha o Nome do Lider.")
                      valida = false
                  }
                 if textNomeAnfitriao.text!.isEmpty {
                      exibeMensagemAlerta (titulo: "Dado Invalido.", mensagem: "Preencha o Nome do anfitrião.")
                      valida = false
                  }
                 if textDia.text!.isEmpty {
                      exibeMensagemAlerta (titulo: "Dado Invalido.", mensagem: "Preencha o dia.")
                      valida = false
                  }
                 if textHorario.text!.isEmpty {
                      exibeMensagemAlerta (titulo: "Dado Invalido.", mensagem: "Preencha o Horario.")
                      valida = false
                  }
        
        return valida
    }
    
    func TelaPrincipal() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func preencheDados(_ dic : NSDictionary!) {
        
        if dic == nil {
            textCep.text = ""
            textLogradouro.text = ""
            textMunicipio.text = ""
            textBairro.text = ""
            textUF.text = ""
        }
        
        else {
            guard let cep = dic.value(forKey: "cep") else {return}
            guard let logradouro = dic.value(forKey: "logradouro") else {return}
            guard let municipio = dic.value(forKey: "localidade") else {return}
            guard let bairro = dic.value(forKey: "bairro") else {return}
            guard let uf = dic.value(forKey: "uf") else {return}
            
            textCep.text = cep as? String
            textLogradouro.text = logradouro as? String
            textMunicipio.text = municipio as? String
            textBairro.text = bairro as? String
            textUF.text = uf as? String
            
        }
    }
    
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneNomeLIder(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func doneNomeAnfitriao(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    

    
    @IBAction func doneLogradouro(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneNumero(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneBairro(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func doneMunicipio(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneUf(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
   
}

extension UITextField{
@IBInspectable var doneAccessory: Bool{
    get{
        return self.doneAccessory
    }
    set (hasDone) {
        if hasDone{
            addDoneButtonOnKeyboard()
        }
    }
}

func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
