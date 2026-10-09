class Parent:
    x = 10;
    
    def setname(self, name):
        self.name = name;
        
        
class FirstClass:
    
    def setname(self, name):
        self.name = name;
    def printname(self):
        print(self.name)
    
class Child(Parent):
    pass;
    
b = Child();
c = Parent();

b.setname('chow');
c.setname('Chowdhury');

print(b.name)

print(c.x);

print(b.x)

print(c.name)


# create new object from the FirstClass


c = FirstClass();

c.setname('Biajid Chowdhury');
c.printname()



