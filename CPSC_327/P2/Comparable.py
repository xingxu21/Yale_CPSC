class ComparableMixin():
    "Assumes that __lt__ and __eq__ are appropriately implemented and derives the remaining comparison methods from these"

    def __ge__(self, other):
        return not self.__lt__(other)

    def __gt__(self, other):
        return not self.__lt__(other) and not self.__eq__(other)

    def __le__(self, other):
        return self.__lt__(other) or self.__eq__(other)

    def __ne__(self, other):
        return not self.__eq__(other)
