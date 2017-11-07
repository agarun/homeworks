# Extending a built-in class

## Topics

* strings and numbers
* modules
* reopening classes

To make this test pass you'll need to extend a built-in
class. You'll see that we're creating a new spec for 'Fixnum' --
this isn't a new class you'll be building, but instead it is a
built-in class you will extend.

Remember that in Ruby, everything is an object, even a number.  Try
this in irb:

    >> 4.class
    => Fixnum
    >> 4.methods
    \["inspect", "%", "<<", ...

The number 4 is of class `Fixnum` and it has methods on it.  Your
challenge is to add an `in_words` method to `Fixnum`.
