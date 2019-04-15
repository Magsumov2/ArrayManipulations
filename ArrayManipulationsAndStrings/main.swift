//
//  main.swift
//  ArrayManipulationsAndStrings
//
//  Created by муса магсумов on 29/01/2019.
//  Copyright © 2019 муса магсумов. All rights reserved.
//

import Foundation

class Node:Comparable{
    
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.val == rhs.val
    }
    
    static func < (lhs: Node, rhs: Node) -> Bool {
        return  lhs.val < rhs.val
    }
    static func > (lhs: Node, rhs: Node) -> Bool {
        return  lhs.val > rhs.val
    }
    
    
    var val:Int
    var next:Node?
    
    init(val:Int) {
        self.val = val
    }
    
    func linkNext(next:Node){
        self.next = next
    }
}
class LinkedListCollection{
    var start:Node?
    
    func add(num:Int){
        let newNode = Node(val: num)
        if start == nil {
            start = newNode
        }else{
            var curent = start
            while curent?.next != nil{
                curent = curent?.next!
            }
            curent?.linkNext(next: newNode)
            
        }
    }
    
    
    func myPrint(){
        print("[",terminator:"")
        var curent = start
        while curent != nil{
            print(curent!.val,terminator:"")
            curent = curent!.next
            if curent != nil {
                print(", ",terminator:"")
            }
        }
        print("]")
    }
    
    
    
    func filtered(by itemSatisface: (Int)->Bool)->LinkedListCollection{
        let anInstance = LinkedListCollection()
        var curent = start
        while curent != nil{
            let v = curent!.val
            if itemSatisface(v){
                anInstance.add(num:v)
            }
            curent = curent!.next
        }
        return anInstance
    }
    
    func filter(_ itemSatisface:(Int)->Bool){
        guard start != nil  else {
            return
        }
        while start != nil && !itemSatisface(start!.val)  {
            start = start!.next
        }
        var current = start
        while current?.next != nil{
            if itemSatisface(current!.next!.val) {
                current = current!.next
            }else{
                current!.next = current!.next!.next
            }
        }
    }
    
    
    func map(by mapedValue:(Int)->Int)->LinkedListCollection{
        let anInstance = LinkedListCollection()
        var curent = start
        while curent != nil{
            anInstance.add(num: mapedValue(curent!.val))
            curent = curent!.next!
        }
        return anInstance
    }
    
    func reduce(initialValue:Int, reducer:(Int,Int)->Int)->Int{
        var result = initialValue
        var cur = start
        while cur != nil{
            result = reducer(result,cur!.val)
            cur = cur!.next
        }
        return result
    }
    
    var size: Int {
        var size = 0
        var cur = start
        while cur != nil{
            cur = cur!.next
            size+=1
        }
        return size
    }
    
    
    func reversed () -> LinkedListCollection{
        let newCollection = LinkedListCollection()
        var size = self.size
        var current = start
        while current != nil{
            var i = 0
            var cur2 = start
            while i < size{
                i+=1
                cur2 = cur2?.next
            }
            newCollection.add(num: cur2!.val)
            size-=1
            current = current?.next
        }
        return newCollection
    }
    
    func clearRepeats(){
        var current = start
        while current != nil{
            var cur2 = current
            while cur2?.next != nil{
                if cur2!.next!.val == current!.val{
                    cur2!.next = cur2!.next?.next
                }else{
                    cur2 = cur2!.next
                }
            }
            current = current!.next
        }
    }
    func insert(at position:Int, num:Int){
        var index = 0
        var current = start
        while current?.next != nil {
            index+=1
            if index == position{
                let newNode:Node? = Node(val: num)
                newNode?.next = current?.next
                current?.next = newNode
                
            }
            current = current?.next
            
            
        }
    }
    
    //FIXME do not change input collection
    func injectToPosition(at until:Int, collection:LinkedListCollection ){
        //проверка на существующий индекс
        if until > size || until < 0{
            print("в списке всего \(size) элементов, также список не может содержать отрицательные позиции")
            return
        }
        //основной код
        var index = 0
        var current = start
        while index < until-1 {
            index+=1
            current = current?.next
        }
        //обработка краевой ситуации
        if until == 0  {
            let value = collection.start
            let newNode = Node(val: value!.val)
            newNode.next = start
            start = newNode
        }
        let end = current?.next
        var tranferValue = until > 0 ? collection.start :  collection.start?.next//переменная для обработки краевой ситуации
        while tranferValue != nil{
            let newNode = Node(val: tranferValue!.val)
            current?.next = newNode
            current = current?.next
            tranferValue = tranferValue?.next
        }
        current?.next = end
    }

    
    
    
    func distinct()->LinkedListCollection{
        let anInstance = LinkedListCollection()
        var current = start
        while current != nil{
            var isThereCopy = false
            var  secondPass = current
            while secondPass != nil{
                if current!.val == secondPass!.next?.val {
                    isThereCopy = true
                    break
                }
                secondPass = secondPass!.next
            }
            if isThereCopy == false{
                anInstance.add(num: current!.val)
            }
            current = current!.next
        }
        return anInstance
    }
    
    func reverse (){
        var buf:Node?
        var current = start
        var next:Node?
        while current != nil{
            next = current!.next
            current!.next = buf
            buf = current
            current = next
        }
        start = buf
    }
    
    func bubbleSortingOfLinkedList(){
        var buf:Int
        var current = start
        while current != nil {
            var newCurrent = start
            while newCurrent?.next != nil {
                if newCurrent! > newCurrent!.next! {
                    buf = (newCurrent?.val)!
                    newCurrent?.val = newCurrent!.next!.val
                    newCurrent?.next?.val = buf
                }
                newCurrent = newCurrent?.next
            }
            current = current?.next
            
        }
        
    }
}







class LinkedList2{
    var start:Node?
    func add(num:Int){
        let newNode = Node(val: num)
        newNode.next = start
        start = newNode
    }
    
    func myPrint(){
        if start == nil {
            print("нечего распечатовать")
        }else{
            print("[",terminator:"")
            var curent = start
            while curent != nil{
                print(curent!.val,terminator:"")
                curent = curent!.next
                if curent != nil {
                    print(", ",terminator:"")
                    
                }
                print("]",terminator:" ")
                
            }
        }
    }
}
class ArrayManipulations{
    func bubleSort(){
        var array = [1,2,3,1,2,4,5,77,76]
        var i = 0
        while i < array.count{
            var buf = 0
            var j = 0
            while j < array.count-1{
                if array[j]>array[i]{
                    buf = array[j]
                    array[j] = array[i]
                    array[i] = buf
                }
                j+=1
            }
            i+=1
        }
        print(array)
    }
    func chosenSortMax(){
        var nums = [1,2,3,1,2,4,100,2,5,6,10,357890,4,5,77,76]
        var size = nums.count-1
        while size > 1{
            var buf  = 0
            var maxI = 0
            var i = 0
            while i < size{
                if nums[i] > nums[i+1]{
                    maxI = i
                }
                if  nums[maxI] > nums[size]{
                    buf = nums[size]
                    nums[size] = nums[maxI]
                    nums[maxI] = buf
                }
                i+=1
            }
            size-=1
        }
        print(nums)
        
    }
    func chosenSortMin(){
        var nums = [1,2,3,1,2,4,100,2,5,6,10,357890,4,5,77,76]
        var buf = 0
        var i = 0
        while i < nums.count{
            var minI = i
            var j = i
            while j < nums.count{
                if nums[j] < nums[minI]{
                    minI = j
                }
                j+=1
            }
            buf = nums[i]
            nums[i] = nums[minI]
            nums[minI] = buf
            i+=1
        }
        print(nums)
        
    }
    func insertionSort(){
        var nums = [1,2,3,1,2,4,100,2,5,6,10,357890,4,5,77,76]
        var buf = 0
        var i = 1
        while i < nums.count{
            var j = i
            while j > 0 && nums[j-1] > nums[j]{
                buf = nums[j-1]
                nums[j-1] = nums[j]
                nums[j] = buf
                j-=1
            }
            i+=1
        }
        print(nums)
    }
}



let lic = LinkedListCollection()

lic.add(num: 1)
lic.add(num: 4)
lic.add(num: 1)
lic.add(num: 2)
lic.add(num: 3)
lic.add(num: 2)
lic.add(num: 3)
lic.add(num: 1)
lic.add(num: 1)
lic.add(num: 2)
lic.add(num: 3)
lic.add(num: 4)
lic.add(num: 5)
lic.add(num: 1)
lic.add(num: 2)
lic.add(num: 3)
lic.add(num: 1)

lic.myPrint()
let am = ArrayManipulations()
am.chosenSortMax()
am.chosenSortMin()
am.insertionSort()




