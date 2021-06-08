//
//  TaskListViewModel.swift
//  ToDoCoreDateMVVM
//
//  Created by Ярослав Шерстюк on 07.06.2021.
//

import Foundation
import CoreData

class TaskListViewModel: ObservableObject {
    
    var title: String = ""
    @Published var tasks: [TaskViewModel] = []
    
    func getAllTasks() {
       tasks = CoreDataManager.shared.getAllTasks().map(TaskViewModel.init)
    }
    
    func delete(_ task: TaskViewModel) {
        let existingTask = CoreDataManager.shared.getTaskById(id: task.id)
        if let existingTask = existingTask {
            CoreDataManager.shared.deleteTask(task: existingTask)
        }
        
        
    }
    
    func save() {
        let task = Task(context: CoreDataManager.shared.persistentContainer.viewContext)
        task.title = title
        
        CoreDataManager.shared.save()
    }
    
    
}

struct TaskViewModel {
    let task: Task
    var id: NSManagedObjectID {
        return task.objectID
    }
    
    var  title: String {
        return task.title ?? ""
    }
}
