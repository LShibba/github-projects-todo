
import unittest
from todo import TodoList


class TestTodoList(unittest.TestCase):

    def setUp(self):
        self.todo = TodoList()

    def test_add_task(self):
        self.todo.add_task("Study GitHub Projects")
        self.assertIn(
            "Study GitHub Projects",
            self.todo.view_tasks()
        )

    def test_remove_task(self):
        self.todo.add_task("Complete assignment")
        result = self.todo.remove_task("Complete assignment")

        self.assertTrue(result)
        self.assertNotIn(
            "Complete assignment",
            self.todo.view_tasks()
        )

    def test_view_tasks(self):
        self.todo.add_task("Task 1")
        self.todo.add_task("Task 2")

        self.assertEqual(
            self.todo.view_tasks(),
            ["Task 1", "Task 2"]
        )

    def test_empty_task(self):
        with self.assertRaises(ValueError):
            self.todo.add_task("")

    def test_remove_nonexistent_task(self):
        result = self.todo.remove_task("Missing Task")
        self.assertFalse(result)


if __name__ == "__main__":
    unittest.main()
