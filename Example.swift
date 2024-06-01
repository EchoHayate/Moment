//
//  example.swift
//  moment
//
//  Created by Allen Wu on 23/05/2024.
//

import Foundation
import SwiftUI

struct Example:View {
    let url: URL?
    
    @State private var data: Data?
    
    private var image:UIImage?{
        if let data = self.data {
            return UIImage(data: data)
        }
        return nil
    }
    
    var body: some View {
        let image = self.image
        return Group{
            if image != nil {
                Image(uiImage: image!)
            } else {
                Color.gray
            }
        }
        .onAppear{
            if let url = self.url, self.data == nil{
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                }
                DispatchQueue.main.async{
                    self.data = data
                }
            }
        }
    }
}
