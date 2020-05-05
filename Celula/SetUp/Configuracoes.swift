//
//  ConfiguraDatePicker.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 31/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import Foundation
import UIKit


class configuracao   {
    
    
    func configuraDatePicker (_ datepicker : UIDatePicker) -> UIDatePicker {
        
        datepicker.datePickerMode = .date
        //linguagem
        let loc = Locale(identifier: "pt")
        datepicker.locale = loc
        
        //data min e data max
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
    
        //max
        components.year = -8
        components.month = 12
        //let maxDate = calendar.date(byAdding: components, to: currentDate)!
        //min
        components.year = -80
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        
        datepicker.minimumDate = minDate
        //datepicker.maximumDate = maxDate
            
        return datepicker
    }
    
    func configuraToolBar (_ toolBar : UIToolbar, _ buttonBar : UIBarButtonItem) -> UIToolbar {
    
        toolBar.sizeToFit()
        
        
        return toolBar
    }
    
    func formataData (data: Date) -> String{
        var dataString: String = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        dataString = dateFormatter.string(from: data)
        
        return dataString
    }
    
    
    
}
