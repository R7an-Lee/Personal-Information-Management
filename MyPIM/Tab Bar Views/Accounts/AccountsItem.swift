/*
**********************************************************
*   Statement of Compliance with the Stated Honor Code   *
**********************************************************
I hereby declare on my honor and I affirm that
 
 (1) I have not given or received any unauthorized help on this assignment, and
 (2) All work is my own in this assignment.
 
I am hereby writing my name as my signature to declare that the above statements are true:
   
      Yuxuan Li
 
**********************************************************
 */
//
//  AccountsItem.swift
//  MyPIM
//
//  Created by Yuxuan Li on 3/17/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct AccountsItem: View {
    
    let account: Accounts
    var body: some View {
        HStack{
                Image(account.category)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100.0, height: 100.0)
            VStack(alignment: .leading) {
                Text(account.title)
                Text(account.category + " Account")
                Text(account.username)
            }
            .font(.system(size: 14))
        }
    }
}

struct AccountsItem_Previews: PreviewProvider {
    static var previews: some View {
        AccountsItem(account: accountStructList[0])
    }
}
