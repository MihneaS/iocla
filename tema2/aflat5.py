class forrange:

    def __init__(self, startOrStop, stop=None, step=1):
        if step == 0:
            raise ValueError('forrange step argument must not be zero')
        if not isinstance(startOrStop, int):
            raise TypeError('forrange startOrStop argument must be an int')
        if stop is not None and not isinstance(stop, int):
            raise TypeError('forrange stop argument must be an int')

        if stop is None:
            self.start = 0
            self.stop = startOrStop
            self.step = step
        else:
            self.start = startOrStop
            self.stop = stop
            self.step = step

    def __iter__(self):
        return self.foriterator(self.start, self.stop, self.step)

    class foriterator:

        def __init__(self, start, stop, step):
            self.currentValue = None
            self.nextValue = start
            self.stop = stop
            self.step = step

        def __iter__(self): return self

        def next(self):
            if self.step > 0 and self.nextValue >= self.stop:
                raise StopIteration
            if self.step < 0 and self.nextValue <= self.stop:
                raise StopIteration
            self.currentValue = forrange.forvalue(self.nextValue, self)
            self.nextValue += self.step
            return self.currentValue

    class forvalue(int):
        def __new__(cls, value, iterator):
            value = super(forrange.forvalue, cls).__new__(cls, value)
            value.iterator = iterator
            return value

        def update(self, value):
            if not isinstance(self, int):
                raise TypeError('forvalue.update value must be an int')
            if self == self.iterator.currentValue:
                self.iterator.nextValue = value + self.iterator.step

s = [218, 230, 231, 253, 174, 239, 237, 230, 231, 235, 248, 235, 227, 235, 224, 250, 174, 237, 239, 226, 226, 253, 174, 232, 225, 252, 174, 225, 224, 235, 174, 225, 232, 174, 227, 247, 174, 232, 239, 248, 225, 252, 231, 250, 235, 174, 255, 251, 225, 250, 235, 253, 180, 174, 203, 250, 174, 250, 251, 162, 174, 204, 252, 251, 250, 235, 232, 225, 252, 237, 235, 177, 0]

l = []


for i in forrange(250):
    l = []
    for i2 in s:
        l.append(chr(i2^i))

    if chr(ord('f')) in l:
        if chr(ord('o')) in l:
            if chr(ord('r')) in l:
                if chr(ord('c')) in l:
                    print i
                    print l
