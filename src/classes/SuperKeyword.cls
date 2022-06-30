public virtual class SuperKeyword {
    
    public virtual class Parent {

        public virtual void display() {

            System.debug('Parent class');
        }
    }

    public virtual class  Child extends Parent {

        public override virtual void display() {

            super.display();
            System.debug('Child Class');
        }
    }
}