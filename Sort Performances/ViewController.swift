//
//  ViewController.swift
//  Sort Performances
//
//  Created by Ferdi Kızıltoprak on 22/04/15.
//  Copyright (c) 2015 Ferdi Kızıltoprak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var array: [Int] = []
    
    @IBOutlet var proQuick: UIProgressView!
    @IBOutlet var timeQuick: UILabel!
    
    @IBOutlet var proSelection: UIProgressView!
    @IBOutlet var timeSelection: UILabel!
    
    @IBOutlet var proMerge: UIProgressView!
    @IBOutlet var timeMerge: UILabel!
    
    @IBOutlet var proInsertion: UIProgressView!
    @IBOutlet var timeInsertion: UILabel!
    
    @IBOutlet var proBubble: UIProgressView!
    @IBOutlet var timeBubble: UILabel!
    
    @IBOutlet var proShell: UIProgressView!
    @IBOutlet var timeShell: UILabel!
    
    @IBOutlet var arraySize: UITextField!
    
    var progress: [Float] = [0.0]
    
    @IBAction func Calculate(sender: UIButton) {
        if let sizeOfArray: Int = arraySize.text.toInt(){
            progress.removeAll(keepCapacity: false)
            fillArray(sizeOfArray)
            var array2 = array
            var startDate: NSDate = NSDate()
            sortMerge(array2)
            var endDate: NSDate = NSDate()
            var dateComponents: NSDateComponents = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(NSCalendarUnit.CalendarUnitNanosecond, fromDate: startDate, toDate: endDate, options: NSCalendarOptions(0))
            progress.append((Float)(dateComponents.nanosecond))
            timeMerge.text = (String)(dateComponents.nanosecond/1000000) + "ms"
            
            array2 = array
            startDate = NSDate()
            sortSelection(array2)
            endDate = NSDate()
            dateComponents = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(NSCalendarUnit.CalendarUnitNanosecond, fromDate: startDate, toDate: endDate, options: NSCalendarOptions(0))
            progress.append((Float)(dateComponents.nanosecond))
            timeSelection.text = (String)(dateComponents.nanosecond/1000000) + "ms"
            
            array2 = array
            startDate = NSDate()
            sortQuick(array2, left: 0, right: sizeOfArray-1)
            endDate = NSDate()
            dateComponents = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(NSCalendarUnit.CalendarUnitNanosecond, fromDate: startDate, toDate: endDate, options: NSCalendarOptions(0))
            progress.append((Float)(dateComponents.nanosecond))
            timeQuick.text = (String)(dateComponents.nanosecond/1000000) + "ms"
            
            array2 = array
            startDate = NSDate()
            sortInsertion(array2)
            endDate = NSDate()
            dateComponents = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(NSCalendarUnit.CalendarUnitNanosecond, fromDate: startDate, toDate: endDate, options: NSCalendarOptions(0))
            progress.append((Float)(dateComponents.nanosecond))
            timeInsertion.text = (String)(dateComponents.nanosecond/1000000) + "ms"
            
            array2 = array
            startDate = NSDate()
            sortBubble(array2)
            endDate = NSDate()
            dateComponents = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(NSCalendarUnit.CalendarUnitNanosecond, fromDate: startDate, toDate: endDate, options: NSCalendarOptions(0))
            progress.append((Float)(dateComponents.nanosecond))
            timeBubble.text = (String)(dateComponents.nanosecond/1000000) + "ms"
            
            array2 = array
            startDate = NSDate()
            sortShell(array2)
            endDate = NSDate()
            dateComponents = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(NSCalendarUnit.CalendarUnitNanosecond, fromDate: startDate, toDate: endDate, options: NSCalendarOptions(0))
            progress.append((Float)(dateComponents.nanosecond))
            timeShell.text = (String)(dateComponents.nanosecond/1000000)
            
            var bigger:Float = 0.0
            var divider: Float = 1
            for var i = 1 ; i < progress.count ; i++ {
                if bigger < progress[i] {
                    bigger = progress[i]
                }
            }
            while(bigger > 1){
                bigger = bigger/2
                divider *= 2
            }
            proMerge.setProgress(progress[0]/divider, animated: true)
            proSelection.setProgress(progress[1]/divider, animated: true)
            proQuick.setProgress(progress[2]/divider, animated: true)
            proInsertion.setProgress(progress[3]/divider, animated: true)
            proBubble.setProgress(progress[4]/divider, animated: true)
            proShell.setProgress(progress[5]/divider, animated: true)
            print(progress)
        }
    }
    
    func fillArray(sizeOfArray: Int){
        array.removeAll(keepCapacity: false)
        for var i = 0; i < sizeOfArray; i++ {
           self.array.append(Int(arc4random_uniform(1)))
        }
    }
    
    func sortQuick (var array: [Int], left: Int, right: Int){
        var i: Int = left, j:Int = right
        var tmp: Int = 0
        var pivot = array[(left + right) / 2]
        
        /* partition */
        while (i <= j) {
            while (array[i] < pivot){
                i++
            }
            while (array[j] > pivot){
                j--
            }
            if (i <= j) {
                tmp = array[i]
                array[i] = array[j]
                array[j] = tmp
                i++
                j--
            }
        }
        
        /* recursion */
        if (left < j){
            sortQuick(array, left: left, right: j)
        }
        if (i < right){
            sortQuick(array, left: i, right: right)
        }
    }
    func sortSelection (array: [Int]){
        var minIndex: Int = 0
        for var index:Int = 0; index < array.count-1; ++index {
            minIndex = index
            for (var j: Int = index + 1; j < array.count-1; ++j) {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            swapNumbers(array, index1: index, index2: minIndex)
        }
    }
    func swapNumbers(var array: [Int], index1 :Int,index2: Int) {
        let temp = array[index1]
        array[index1] = array[index2]
        array[index2] = temp
    }
    func elementsInRange<T>(a: [T], start: Int, end: Int) -> ([T]) {
        var result = [T]()
        
        for var x=start; x<end; x++ {
            result.append(a[x])
        }
        
        return result
    }
    func merge<T: Comparable>(a: [T], b: [T], mergeInto acc: [T]) -> [T] {
        if a == [] {
            return acc + b
        } else if b == [] {
            return acc + a
        }
        
        if a[0] < b[0] {
            return merge(elementsInRange(a, start: 1, end: a.count), b: b, mergeInto: acc + [a[0]])
        } else {
            return merge(a, b: elementsInRange(b, start: 1, end: b.count), mergeInto: acc + [b[0]])
        }
    }
    func sortMerge<T: Comparable>(a: [T]) -> [T] {
        if a.count <= 1 {
            return a
        } else {
            let firstHalf = elementsInRange(a, start: 0, end: a.count/2)
            let secondHalf = elementsInRange(a, start: a.count/2, end: a.count)
            
            return merge(sortMerge(firstHalf), b: sortMerge(secondHalf), mergeInto: [])
        }
    }
    func sortInsertion(var array: [Int]) {
        var j,i:Int
        
        for i = 1; i < array.count; i++ {
            var temp = array[i]
            j = i
            while (j > 0 && array[j - 1] >= temp ) {
                array[j] = array[j - 1]
                --j
            }
            array[j] = temp
        }
    }
    func sortBubble<T:Comparable>(var array:[T]) {
        var done = false
        while !done {
            done = true
            for i in 1..<array.count {
                if array[i - 1] > array[i] {
                    (array[i], array[i - 1]) = (array[i - 1], array[i])
                    done = false
                }
            }
        }
    }
    func sortShell (var array: [Int]){
        var increment = array.count/2
        while (increment > 0) {
            for (var i = increment; i < array.count; i++) {
                var j = i;
                var temp = array[i];
                while (j >= increment && array[j - increment] > temp) {
                    array[j] = array[j - increment];
                    j = j - increment;
                }
                array[j] = temp;
            }
            if (increment == 2) {
                increment = 1;
            } else {
                increment *= (Int)(5.0 / 11);
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

