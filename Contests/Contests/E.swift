//E. Сокращение маршрута
//Ограничение времени    1 секунда
//Ограничение памяти    64Mb
//Ввод    стандартный ввод или input.txt
//Вывод    стандартный вывод или output.txt

//Вам поручили дойти из точки А в точку Б.
//
//Предыдущий путешественник по этому маршруту оставил вместо карты краткое описание маршрута с направлениями движения и дистанциями. Однако у него на пути были промежуточные точки, из-за чего в описании встречаются тупики. Вам очень хочется вовремя попасть в точку B и не тратить на тупики драгоценное время.
//
//Ваша задача - убрать из маршрута тупики при их наличии. Также необходимо сократить одинаковые направления, если они идут друг за другом.
//
//Маршрутом считается набор действий. Действие — направление движения и дистанция.
//
//Тупиком считаются последовательные действия в строго противоположных направлениях движения. Например, если требуется пойти TOP 50 и следующим шагом BOTTOM 50, то это считается тупиком, и данные действия можно полностью сократить (тогда в выводе не должно быть этих строчек). Однако если дистанции не сокращаются полностью, то полностью сократить действия нельзя. Например, если требуется пойти TOP 50, и следующим шагом BOTTOM 40, то это можно сократить в TOP 10.
//Тупиком не считается возвращение в точку маршрута по другой дороге. Например, если требуется пойти TOP 50, RIGHT 50, BOTTOM 50, LEFT 50, BOTTOM 10, то данные действия сократить до BOTTOM 10 нельзя.
//
//Пример одинаковых направлений, идущих друг за другом — BOTTOM 50, BOTTOM 50. Это необходимо сократить в BOTTOM 100
//
//Формат ввода
//Изначальный маршрут.
//
//В каждой строке действие. Действие — направление R и дистанция D (0 < D < 10000) в формате "НАПРАВЛЕНИЕ ДИСТАНЦИЯ". Между направлением и дистанцией пробел.
//
//Количество строк N (0 < N < 1000).
//
//Дистанции бывают только целыми числами.
//
//Формат вывода
//Обработанный маршрут — без тупиков и с сокращёнными одинаковыми направлениями, если они идут друг за другом.
//
//В каждой строке - действие. Действие — направление R и дистанция D в формате "НАПРАВЛЕНИЕ ДИСТАНЦИЯ". Между направлением и дистанцией — пробел.
//
//Дистанции бывают только целыми числами.

//import Foundation
//
//enum Direction {
//    case TOP
//    case RIGHT
//    case LEFT
//    case BOTTOM
//}
//
//func isOpposite(first: Direction, second: Direction) -> Bool {
//    switch first {
//    case .TOP:
//        if second == .BOTTOM {
//            return true
//        } else {
//            return false
//        }
//    case .BOTTOM:
//        if second == .TOP {
//            return true
//        } else {
//            return false
//        }
//    case .LEFT:
//        if second == .RIGHT {
//            return true
//        } else {
//            return false
//        }
//    case .RIGHT:
//        if second == .LEFT {
//            return true
//        } else {
//            return false
//        }
//    }
//}
//
//func getOpposite(direction: Direction) -> Direction {
//    switch direction {
//    case .TOP:
//        return .BOTTOM
//    case .RIGHT:
//        return .LEFT
//    case .LEFT:
//        return .RIGHT
//    case .BOTTOM:
//        return .TOP
//    }
//}
//
//func getStr(direction: Direction) -> String {
//    switch direction {
//    case .TOP:
//        return "TOP"
//    case .RIGHT:
//        return "RIGHT"
//    case .LEFT:
//        return "LEFT"
//    case .BOTTOM:
//        return "BOTTOM"
//    }
//}
//
//var stack: [(direction: Direction, value: Int)] = []
//while let input = readLine() {
//    let inputParsed = input.split(separator: " ")
//    let direction = inputParsed[0]
//    var directionEnum = Direction.TOP
//    switch direction {
//    case "TOP":
//        directionEnum = .TOP
//        break
//    case "RIGHT":
//        directionEnum = .RIGHT
//        break
//    case "LEFT":
//        directionEnum = .LEFT
//        break
//    case "BOTTOM":
//        directionEnum = .BOTTOM
//        break
//    default:
//        break
//    }
//    let value = Int(inputParsed[1])!
//    if let prev = stack.last {
//        stack.removeLast()
//        if prev.direction == directionEnum {
//            stack.append((prev.direction, prev.value + value))
//        } else if isOpposite(first: prev.direction, second: directionEnum) {
//            let diff = prev.value - value
//            if diff > 0 {
//                stack.append((prev.direction, diff))
//            } else if diff < 0 {
//                let newDir = getOpposite(direction: prev.direction)
//                if let prevPrev = stack.last {
//                    if newDir == prevPrev.direction {
//                        stack.removeLast()
//                        stack.append((prevPrev.direction, prevPrev.value + (diff * -1)))
//                        continue
//                    }
//                }
//                stack.append((newDir, diff * -1))
//            }
//        } else {
//            stack.append(prev)
//            stack.append((directionEnum, value))
//        }
//    } else {
//        stack.append((directionEnum, value))
//    }
//}
//
//for el in stack {
//    print(getStr(direction: el.direction), el.value)
//}
