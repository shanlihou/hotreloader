"""
Example Python file to demonstrate the PythonContext command.
Place your cursor at different positions and run :PythonContext to see the context.
"""


class UserManager:
    """Manages user-related operations."""

    def __init__(self):
        self.users = []

    def add_user(self, username):
        """Add a new user to the system."""
        self.users.append(username)
        print(f"User {username} added")

    def remove_user(self, username):
        """Remove a user from the system."""
        if username in self.users:
            self.users.remove(username)
            print(f"User {username} removed")
        else:
            print(f"User {username} not found")

    def list_users(self):
        """List all users."""
        for user in self.users:
            print(f"- {user}")


class DatabaseManager:
    """Manages database operations."""

    def connect(self, connection_string):
        """Connect to the database."""
        self.connection = connection_string
        return True

    def execute_query(self, query):
        """Execute a database query."""
        return f"Executing: {query}"


def utility_function():
    """A standalone utility function."""
    return "utility"


def process_data(data):
    """Process the given data."""
    result = []
    for item in data:
        if isinstance(item, int):
            result.append(item * 2)
        else:
            result.append(item)
    return result


if __name__ == "__main__":
    # Main execution block
    user_mgr = UserManager()
    user_mgr.add_user("alice")
    user_mgr.add_user("bob")
    user_mgr.list_users()
