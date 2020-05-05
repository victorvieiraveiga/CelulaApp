//
//  ReuniaoCadastroViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 01/04/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class ReuniaoCadastroViewController: UIViewController, UITextViewDelegate {

    
    
    var participantes : [NSManagedObject] = []
    var participantesSelecionados = [NSManagedObject]()
    var celula : [NSManagedObject] = []
    var partObject  = FormataParticipantes()
    var reuniaoObject = FormataReuniao()
    var celulaObject = FormataCelula()
    let pickerViewNome: UIPickerView = UIPickerView()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textDataEvento: UITextField!
    @IBOutlet weak var textObs: UITextView!
    @IBOutlet weak var textNomeCelula: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                      NotificationCenter.default.addObserver(self, selector: #selector(aumentarScroll), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        textObs.delegate = self
        textNomeCelula.inputView = pickerViewNome
        participantes = partObject.CarregaParticipante()
        celula = celulaObject.CarregaCelula()
        configTextNomeCelula()
        initialize()
        inicio()
        CriaTollBar()
        configTextView()
        self.tableView.isEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        

    }
    

     @objc func aumentarScroll (notification: Notification) {
//        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height + 320)
        print ("scroll teste")
    }
     
    
    func configTextNomeCelula () {
        if celula.count == 1 {
            guard let cel = celula[0].value(forKey: "nome") else {return}
            textNomeCelula.text = cel as? String
            textNomeCelula.isEnabled = false
        }
    }
    
    func configTextView () {
        self.textObs.layer.borderColor =  UIColor.separator.cgColor
        self.textObs.layer.borderWidth = 1
        self.textObs.layer.cornerRadius = 10
        textObs.text = "Observações"
        textObs.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Observações"
            textView.textColor = UIColor.lightGray
        }
    }
    

    @IBAction func entraFocoDataEvento(_ sender: UITextField) {
        let datePickerHorario : UIDatePicker = UIDatePicker()
               //Configura DatePicker
               let config = configuracao()
               sender.inputView =  config.configuraDatePicker(datePickerHorario)
               datePickerHorario.addTarget(self, action: #selector(exibeData(sender:)), for: .valueChanged)
    }
    
    
    @objc func exibeData (sender: UIDatePicker) {
           let formatador = DateFormatter()
           formatador.dateFormat = "dd/MM/yyyy"
        self.textDataEvento.text = formatador.string(from: sender.date)
       }
    
    
    @IBAction func salvarReuniao(_ sender: Any) {
        addReuniao()
    }
    
    func exibeMensagemAlerta (titulo: String, mensagem:String){
         let myAlert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
         let oKAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
         myAlert.addAction(oKAction)
         self.present(myAlert, animated: true, completion: nil)
     }
    
    func addReuniao () {
        //variaveis de conexao com coreData
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
        
            let conectBD = NSEntityDescription.insertNewObject(forEntityName: "ReuniaoCelulaDB", into: context!)
            guard let nomeCelula = textNomeCelula.text else {return}
            guard let dataEvento = self.textDataEvento.text else {return}
            //convert string para date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.date(from: dataEvento)
            
            guard let obs = self.textObs.text else {return}
            
            let idReuniao = reuniaoObject.geraIdReuniao()
            
            conectBD.setValue(nomeCelula, forKey: "nomeCelula")
            conectBD.setValue(date, forKey: "data")
            conectBD.setValue(obs, forKey: "observacao")
            conectBD.setValue(idReuniao, forKey: "id")
       
        
        do {
            try context?.save()
           } catch  {
               print("Erro ao Salvar Reuniao")
           }
        
        for part in self.participantesSelecionados {
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            let conectBDPart = NSEntityDescription.insertNewObject(forEntityName: "ParticipantesReuniaoCelulaDB", into: context!)
            
            let participante = part.value(forKey: "nome")
            conectBDPart.setValue(participante, forKey: "nome")
            conectBDPart.setValue(idReuniao, forKey: "idReuniao")
            conectBDPart.setValue(nomeCelula, forKey: "nomeCelula")
            
            do {
                   try context?.save()
                   
                  } catch  {
                      print("Erro ao Salvar Participante da Reniao")
                  }
        }
        
        TelaPrincipal()
        
    }
    
    func TelaPrincipal() {
        self.navigationController?.popViewController(animated: true)
    }
    
     func CriaTollBar () {
         let toolBar = UIToolbar()
         toolBar.sizeToFit()
         let botaoOk = UIBarButtonItem(title: "OK", style: .done, target: self, action:#selector(self.dismissKeyboard))
         toolBar.setItems([botaoOk], animated: false)
         toolBar.isUserInteractionEnabled = true
         textDataEvento.inputAccessoryView = toolBar
         textObs.inputAccessoryView = toolBar
         textNomeCelula.inputAccessoryView = toolBar
         
         let toolbarDone = UIToolbar.init()
         toolbarDone.sizeToFit()
     }
     
     @objc func dismissKeyboard() {
         self.view.endEditing(true)
     }
    
    @IBAction func selecaoMultipla(_ sender: UIButton) {
        self.participantesSelecionados.removeAll()
        if sender.isSelected {
            for row in 0..<self.participantes.count {
                self.tableView.selectRow(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .none)
                
            }
            sender.isSelected = false
            sender.setImage(UIImage(named: "selected.png"), for: .normal)
            self.participantesSelecionados = participantes
            print (self.participantesSelecionados)
            
        } else {
             for row in 0..<self.participantes.count {
                self.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
                           
             }
            sender.isSelected = true
            sender.setImage(UIImage(named: "unSelected.png"), for: .normal)
            self.participantesSelecionados.removeAll()
             print (self.participantesSelecionados)
        }
    }
}

extension ReuniaoCadastroViewController : UIPickerViewDelegate, UIPickerViewDataSource {

    func initialize () {
        pickerViewNome.dataSource = self
        pickerViewNome.delegate = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        celula.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = self.celula[row].value(forKey: "nome")
        return row as! String
     }

     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textNomeCelula.text = self.celula[row].value(forKey: "nome") as! String
     }


}

extension ReuniaoCadastroViewController : UITableViewDelegate, UITableViewDataSource {
    
    func inicio() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        participantes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReuniaoParticipantesTableViewCell
        let participante = self.participantes [indexPath.row]
        cell.configuraParticipanteCell(participante)
        
        return cell
    }
    
    

    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    self.selectDeselectCell(tableview: tableView, indexPath: indexPath)
    print ("Select")
    
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableview: tableView, indexPath: indexPath)
    }
    
    func selectDeselectCell (tableview : UITableView, indexPath: IndexPath) {
        self.participantesSelecionados.removeAll()
        if let arr = tableView.indexPathsForSelectedRows {
               for index in arr {
                   self.participantesSelecionados.append(self.participantes[index.row])
               }
           }
           print (participantesSelecionados)
    }
    
}


