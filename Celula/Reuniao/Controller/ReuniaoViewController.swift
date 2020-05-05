//
//  ReuniaoViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 26/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData
import MessageUI


class ReuniaoViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var reuniaoList : [NSManagedObject] = []
    var participantesReuniao : [NSManagedObject] = []
    var reuniaoObject = FormataReuniao()
    var partReuniaoObject = FormataParticipantes()
    var celulaObject = FormataCelula()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.delegate = self
        tableView.dataSource = self
        self.reuniaoList = reuniaoObject.CarregaReuniao()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.reuniaoList = reuniaoObject.CarregaReuniao()
        tableView.reloadData()
    }
    

    
    @IBAction func chamaTelaCadastro(_ sender: Any) {
        
        
        if celulaObject.existeCelula() == false {
            exibeMensagemAlerta(titulo: "Atenção.", mensagem: "Inclua primeiro uma celula.")
        }else {
            
            if partReuniaoObject.existeParticipantes() == false {
                 exibeMensagemAlerta(titulo: "Atenção.", mensagem: "Inclua primeiro os participantes.")
            }
            else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(identifier: "reuniaoCadastro") as! ReuniaoCadastroViewController
                navigationController?.pushViewController(controller, animated: true)
            }
        }
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.reuniaoList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReuniaoTableViewCell
        
        let reuniao = reuniaoList[indexPath.item]
        let id = reuniao.value(forKey: "id") as! String

        
        self.participantesReuniao = partReuniaoObject.CarregaParticipantesReuniao(idReuniao: id, nomeCelula: "Celula Victor")
        cell.configuraReuniao(reuniao: reuniao, participantes: self.participantesReuniao )
        cell.botaoCompartilhar.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let reuniaoItem = self.reuniaoList[indexPath.row]
        let idReuniao = reuniaoItem.value(forKey: "id") as! String
        
        //exclui primeiro os participantes
        excluiParticipantes(idReuniao)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        context?.delete(reuniaoItem)
               
           do {
                try context?.save()
               } catch let erro {
                   print ("Erro ao remover item \(erro)")
               }
        self.reuniaoList.remove(at: indexPath.row)
        
        tableView.reloadData()
    }
    
    func excluiParticipantes (_ idReuniao: String) {
        
        let participantes =  partReuniaoObject.CarregaParticipantesReuniao(idReuniao: idReuniao, nomeCelula: "")
        for part in participantes {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            context?.delete(part)
            
            do {
                 try context?.save()
                } catch let erro {
                    print ("Erro ao remover item \(erro)")
                }
        }
    }
    
    func TelaPrincipal() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func exibeMensagemAlerta (titulo: String, mensagem:String){
         let myAlert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
         let oKAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
         myAlert.addAction(oKAction)
         self.present(myAlert, animated: true, completion: nil)
     }
    
    

    
    @IBAction func compartilharEmail(_ sender: UIButton) {
            
            let indice =  sender.tag
            let setup = configuracao()
            let formata = FormataReuniao()
            let data =  self.reuniaoList[indice].value(forKey: "data")
            let dataString = setup.formataData(data: data as! Date)
            
        
            var participantes: [NSManagedObject] = []
            var participantesString : String = ""
            guard let idReuniao = self.reuniaoList[indice].value(forKey: "id") else {return}
            guard let obs = self.reuniaoList[indice].value(forKey: "observacao") else {return}
            guard let celulaNome = self.reuniaoList[indice].value(forKey: "nomeCelula") else {return}
            
        
            participantes = partReuniaoObject.CarregaParticipantesReuniao(idReuniao: idReuniao as! String, nomeCelula: "")
            participantesString = formata.DesenbrulhaParticipantes(participantes)
            
            let atribute1 = NSMutableAttributedString(string: celulaNome as! String)
            atribute1.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 8))
            atribute1.addAttribute(.font, value: UIFont.fontNames(forFamilyName:"Avenir Black"), range: NSRange(location: 0, length: 8))
            
            let conteudo = "<p> <font face='Avenir'> <h3>\(celulaNome) </h3> <b> Data: </b> \(dataString) <br/>  <b>Participantes: </b> \(participantesString) <br/> <b> Observação: </b> \(obs) </p>"
            
            PreparaEmail (texto: conteudo)
    }
    
    func PreparaEmail (texto: String) {
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            
            composer.mailComposeDelegate = self
            composer.setSubject("Relatório de Celula")
            composer.setMessageBody(texto, isHTML: true)
            present(composer, animated: true)
        } else {
            print("Erro ao enviar email. ")
        }
    }
}

extension ReuniaoViewController : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _  = error {
            controller.dismiss(animated: true)
        }
        
        switch result {
        case .cancelled:
            print ("Cancelado")
        case .failed:
            print ("Falha ao enviar")
        case .saved:
            print ("Salvo")
        case .sent:
            print ("Enviado")
      
        @unknown default:
           print ("Erro.")
        }
         controller.dismiss(animated: true)
    }
}
