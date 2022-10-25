import SwiftSugar

public extension String {
    var fixingCommasWithoutSpaces: String {
        let groups = capturedGroups(using: #"^([^, ]*),([^, ]*)$"#)
        if groups.count > 1 {
            return "\(groups[0]), \(groups[1])"
        }
        return self
    }
    
    func unitString(for amount: Double, lowercased: Bool = true) -> String {
        let isPlural = amount.rounded(toPlaces: amount < 1 ? 2 : 1) >= 2

        let string: String
        if let plural = Plurals[self.lowercased()] {
            string = isPlural ? plural : self
        }
        else if let firstWord = self.firstCapturedGroup(using: #"^([^ ,\(]*).*"#)
        {
            if let pluralEntry = firstWord.lowercased().pluralEntry {
                /// if the first word can be pluralized
                let pluralized = isPlural ? pluralEntry.value : pluralEntry.key
                var cleaned = replacingOccurrences(of: firstWord, with: pluralized).lowercased()
                
                /// consolidate all  strings like `cups (raw)` → `cups, raw`
                cleaned = cleaned.replacingOccurrences(of: ", (", with: ", ")
                cleaned = cleaned.replacingOccurrences(of: " ,", with: ",")
                cleaned = cleaned.replacingOccurrences(of: " (", with: ", ")
                cleaned = cleaned.replacingOccurrences(of: "(", with: ", ")
                cleaned = cleaned.replacingOccurrences(of: ")", with: "")
                
                //TODO: document this
                cleaned = cleaned.fixingCommasWithoutSpaces
                string = cleaned
            } else {
                string = self
            }
        } else {
            string = self
        }
        return lowercased ? string.lowercased() : string
    }
}
