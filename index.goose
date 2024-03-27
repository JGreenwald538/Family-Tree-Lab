import "std:math"
import "std:readline"

struct Node(value, left, right)

const norma = Node("Norma L")
const jackOld = Node("Jack L")
const barbara = Node("Barbara G")
const irving = Node("Irving G")
const cheryl = Node("Cheryl G", norma, jackOld)
const brian = Node("Brian G", barbara, irving)
const jack = Node("Jack G", brian, cheryl)

const family = [norma, jackOld, barbara, irving, cheryl, brian, jack]

fn distanceChecker(member)
    if member == null 
        return 0
    end
    if (member.left == null && member.right == null) 
        return 0
    end
    let left = distanceChecker(member.left)
    let right = distanceChecker(member.right)
    return 1 + if left > right then left else right
end

let distance = 0

const tree = {}

const treeMarkers = ["Root", "Parents", "Grandparents", "Great Grandparents", "Great Great Grandparents", "Great Great Great Grandparents", "Great Great Great Great Grandparents", "Great Great Great Great Great Grandparents", "Great Great Great Great Great Great Grandparents", "Great Great Great Great Great Great Great Grandparents", "Great Great Great Great Great Great Great Great Grandparents", "Great Great Great Great Great Great Great Great Great Grandparents"]

for member in family
    const tempDistance = distanceChecker(member)
    if tree[tempDistance] == null
        tree[tempDistance] = [member]
    else
        tree[tempDistance].push(member)
    end
    if distance < tempDistance
        distance = tempDistance
    end
end

for n in 0 to distance+1
    print(treeMarkers[distance-n] + ":\n")
    for member in tree[n]
        print(member.value + "\t")
    end
    println("")
end

const inputGenerations = int.parse(readline.prompt("Enter the number of generations you want to make: "))
let newFamily = []
const newTree = {}

for n in inputGenerations to 0 step -1
    let newName = ""
    repeat while newName != "quit"
        newName = readline.prompt("Enter the name of the new member of generation " + n + " or type 'quit' to exit: ")
        if newName != "quit"
            let newMember = Node(newName)
            if n < inputGenerations
                for x in 0 to 2
                    let parent = readline.prompt("Enter the name of the parent of " + newName + ": ")
                    let parentExists = false
                    repeat while !parentExists
                        for member in newFamily
                            if member.value == parent
                                parentExists = true
                            end
                        end
                        if parentExists
                            for member in newFamily
                                if member.value == parent
                                    if member.left == null
                                        newMember.left = member
                                    else
                                        newMember.right = member
                                    end
                                end
                            end
                        else
                            parent = readline.prompt("The parent you entered does not exist. Please enter the name of the parent of " + newName + ": ")
                        end
                    end
                end
            end
            newFamily.push(newMember)
            if newTree[n] == null
                newTree[n] = [newMember]
            else
                newTree[n].push(newMember)
            end
        end
    end
end

for member in newFamily
    const tempDistance = distanceChecker(member)
    if tree[tempDistance] == null
        tree[tempDistance] = [member]
    else
        tree[tempDistance].push(member)
    end
    if distance < tempDistance
        distance = tempDistance
    end
end

for n in distance to 0 step -1
    print(treeMarkers[n-1] + ":\n")
    for member in newTree[n]
        print(member.value + "\t")
    end
    println("")
end