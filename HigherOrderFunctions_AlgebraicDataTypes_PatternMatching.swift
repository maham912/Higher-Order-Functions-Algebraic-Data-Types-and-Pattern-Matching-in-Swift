

indirect enum MyList<A> {
    case cons(A, MyList<A>)
    case empty
}

extension MyList {

func isEmpty() -> Bool{
   switch self{
       case .empty:
       return true
       case .cons( _, _):
       return false
   }
    }

    func append (other: MyList<A>) -> MyList<A>{
        switch self{
            case .empty:
            return other;
            case .cons (let head, let tail):
            return MyList<A>.cons(head, tail.append(other : other));
        }
    }

    func length() -> Int{ //other: MyList<A>
        switch self{
            case .empty:
            return 0;
            case .cons ( _,let tail):
            let something = tail.length(); //  let something = tail.length(other: other);

            return 1 + something;
        }
    }

    func filter( predicate:(A) -> (Bool)) -> MyList<A>{
        switch self{
            case .empty:
            return self;
            case .cons(let head, let tail):
            let filtered: MyList<A> = tail.filter(predicate: predicate)
            if predicate(head){
                let newList = MyList.cons(head, filtered)
                return newList;
            }else{
                return filtered;
            }
          }
    }

    func contains(target: A, compare: (A,A) -> Bool) -> Bool{
        switch self{
            case .empty:
            return false
            case .cons (let head, let tail):

           let anything = tail.contains(target: target, compare: compare)

            if(compare(head,target)){
            return true;
            }
            else{
                return anything
            }
        }
    }

    func sum(zero : A, add: (A,A) -> A) -> (A){
        switch self{
        case .empty: 
        return zero
        case .cons(let head, let tail):
        let something = tail.sum( zero : zero, add:add)
        return add(something, head)
        }
    }


    func map<B>(mapper: (A) -> B) -> MyList<B> {
        return mapFunction(list: self, mapper: mapper)
    } // map

    func toString(innerToString: (A) -> String) -> String {
        return "[" + contentsToString(innerToString) + "]"
    } // toString

    func equals(otherList: MyList<A>, compareInner: (A, A) -> Bool) -> Bool {
        switch (self, otherList) {
        case let (.cons(head1, tail1), .cons(head2, tail2)):
            return compareInner(head1, head2) && tail1.equals(otherList: tail2, compareInner: compareInner)
        case (.empty, .empty):
            return true
        case _:
            return false
        }
    } // equals
} // extension MyList


