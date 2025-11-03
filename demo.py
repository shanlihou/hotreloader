#!/usr/bin/env python3
"""
Demonstration of the PythonContext command.

This file contains various Python constructs to test the LSP-based context detection.
Run :PythonContext with your cursor at different positions to see the output.
"""


# Top-level function
def top_level_function():
    """This is a top-level function."""
    print("Inside top_level_function")

    # Nested function inside top-level
    def nested_function():
        """This is nested inside top_level_function."""
        pass

    # Loop with nested function
    for i in range(10):
        def loop_function():
            """This is inside a loop."""
            print(i)


# Class with various methods
class ExampleClass:
    """Example class with multiple methods and nested classes."""

    def __init__(self, name):
        self.name = name

    def public_method(self):
        """A public method."""
        print("Public method")

        # Local function inside method
        def local_helper():
            """Helper function inside method."""
            return self.name

        return local_helper()

    def _private_method(self):
        """A private method (by convention)."""
        pass

    @classmethod
    def class_method(cls):
        """A class method."""
        print(f"Class: {cls.__name__}")

    @staticmethod
    def static_method():
        """A static method."""
        print("Static method")

    @property
    def name_property(self):
        """A property."""
        return self.name

    # Nested class
    class NestedClass:
        """A class nested inside ExampleClass."""

        def nested_method(self):
            """Method inside nested class."""
            pass


class AnotherClass:
    """Another class to test context switching."""

    def method_one(self):
        """First method."""
        pass

    def method_two(self):
        """Second method."""
        # Call method from other class
        obj = ExampleClass("test")
        obj.public_method()


# Class with inheritance
class SubClass(ExampleClass):
    """Subclass demonstrating inheritance."""

    def overridden_method(self):
        """Method that overrides parent."""
        # Call parent method
        super().public_method()

    def new_method(self):
        """New method in subclass."""
        pass


# Class with multiple nested classes
class ComplexClass:
    """Class with multiple levels of nesting."""

    class Level1:
        """First level of nesting."""

        class Level2:
            """Second level of nesting."""

            class Level3:
                """Third level of nesting."""

                def deep_method(self):
                    """Deeply nested method."""
                    pass


# Async function
async def async_function():
    """An async function."""
    await some_async_call()

    # Async nested
    async def nested_async():
        """Nested async function."""
        pass


# Generator function
def generator_function():
    """A generator function."""
    for i in range(100):
        # Generator with nested function
        def helper():
            return i * 2
        yield helper()


# Context manager
class ContextManager:
    """A context manager."""

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        pass

    def method_in_context(self):
        """Method called within context."""
        pass


# Decorated functions
@decorator
def decorated_function():
    """A decorated function."""
    pass


def function_with_decorator():
    """Function with inline decorator."""
    @lambda x: x * 2
    def inner():
        pass


# Test lambda context
lambdas = [
    lambda x: x + 1,
    lambda y: y * 2,
    lambda z: z - 1
]

# Place your cursor below and run :PythonContext
# to see "ComplexClass.Level1.Level2.Level3.deep_method"
# The actual context depends on where your cursor is!

if __name__ == "__main__":
    # Main execution block
    print("Testing PythonContext command")

    # Create instances
    obj = ExampleClass("test")
    obj.public_method()

    # Test nested classes
    nested = ExampleClass.NestedClass()
    nested.nested_method()

    # Test deep nesting
    deep = ComplexClass.Level1.Level2.Level3()
    deep.deep_method()
