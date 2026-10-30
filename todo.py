
# Simple Todo Application

class TodoList:
    def __init__(self):
        self.tasks = []

    def add_task(self, task):
        if not task.strip():
            raise ValueError("Task cannot be empty")
        self.tasks.append(task)
        return True

    def remove_task(self, task):
        if task in self.tasks:
            self.tasks.remove(task)
            return True
        return False

    def view_tasks(self):
        return self.tasks.copy()


if __name__ == "__main__":
    todo = TodoList()

    todo.add_task("Complete GitHub Projects practical")
    todo.add_task("Test CI/CD pipeline")

    print("Current Todo List:")
    for i, task in enumerate(todo.view_tasks(), start=1):
        print(f"{i}. {task}")
