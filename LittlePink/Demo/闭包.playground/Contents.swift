import UIKit

enum Animal {
    case people(String)
    case other
}

let a = Animal.people("张三")
if case .people(let name) = a {
     print(name)
}



let label: UILabel = {
    let label = UILabel()
    label.text = "xxxx"
    return label
}()

let learn = {(lan: String) -> String in
    "学习\(lan)"
}

learn("iOS")

func codingSwift(day: Int, appName: () -> String) {
    print("学习Swift\(day)天了, 写了\(appName())这个APP")
}

codingSwift(day: 2, appName: {
    () -> String in
    "小粉书"
})

codingSwift(day: 2, appName: {
    () in "小粉书"
})

//尾随闭包
codingSwift(day: 2) {
    "小粉书"
}

func codingOC(appName:() -> String) {
    print("学习OC,写了\(appName())App")
}

codingOC {
    "湾区绿菜"
}

//codingSwift(day: 2) { () -> String in
//    "小粉书"
//}
