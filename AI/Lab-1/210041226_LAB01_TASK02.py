class FrequencyMap:
    def __init__(self, words):
        self.word_count = {}
        for word in words:
            if word in self.word_count:
                self.word_count[word] += 1
            else:
                self.word_count[word] = 1
    def most_common(self):
        if not self.word_count:
            return None
        return max(self.word_count, key=self.word_count.get)

if __name__ == "__main__":
    
    print("Example usage:\n")
    print("Creating FrequencyMap with words: ['apple', 'banana', 'apple', 'apple', 'pear']")
    
    f = FrequencyMap ([ " apple " , " banana " , " apple " , " apple " , " pear "])
    print("Most common word:", f.most_common())
    
    words = input("Enter words separated by spaces: ").split()
    freq_map = FrequencyMap(words)
    print("Most common word:", freq_map.most_common())


