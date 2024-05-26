//
//  data.swift
//  moment
//
//  Created by Allen Wu on 05/04/2024.
//
import Foundation

func createData() -> [MessageModel] {
    
    var list = [MessageModel]()
    
    let text = MessageModel(type: .text)
    text.contentText = """
    Halo is a military science fiction media franchise centered on a series of video games managed and developed by 343 Industries, a division of Xbox Game Studios.
"""
    text.comment = createComments()
    list.append(text)
    
    let image = ImageModel(type: .image)
    image.contentText = "Halo was originally developed by Bungie Studios."
    list.append(image)
    image.comment = createComments()
    
    let multiImage = MultiImageModel(type: .MutiImage)
    multiImage.contentText = """
    In Halo, players experience gameplay from a first-person perspective, with futuristic weapons and vehicles in addition to human and alien enemies.
    """
    multiImage.count = 3
    multiImage.comment = createComments()
//    print("Top = \(multiImage.supTopHeight)")
    list.append(multiImage)
    
//    let url = URL(string: "https://picsum.photos/id/237/200/300")!
    
    
    
    let webImageModel = WebImageModel(type: .webImage)
    let webImage = webImageModel.downloadAndSaveImage(from: "https://picsum.photos/id/237/200/300")
    list.append(webImage)

    let text1 = MessageModel(type: .text)
    text1.contentText = """
    Halo is a military science fiction media franchise centered on a series of video games managed and developed by 343 Industries, a division of Xbox Game Studios.
"""
    text1.comment = createComments()
    list.append(text1)
    return list
}

func createComments() -> [CommentModel] {
    var list = [CommentModel]()
//    print(3)
    let first = CommentModel()
    let firstPerson = CommentItemModel()
    firstPerson.name = "John"
    firstPerson.id = "1"
    first.content = "Halo's story revolves around the interstellar war between humanity and an alliance of aliens known as the Covenant."
    first.person = firstPerson
    list.append(first)
    
    
    let second = CommentModel()
    let secondPerson = CommentItemModel()
    secondPerson.name = "Cortana"
    secondPerson.id = "2"
    second.person = secondPerson
    
    let secondEnd = CommentItemModel()
    secondEnd.name = "John"
    secondEnd.id = "3"
    second.endPeseron = secondEnd
    second.content = "Halo features a rich and immersive universe with deep lore and memorable characters."
    
    list.append(second)
//    print(list)
    return list
    
}

