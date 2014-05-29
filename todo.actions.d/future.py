#!/usr/bin/python

import sys
import os

FUTURE_TAG = "@future"

def main(argv):
    FUTURE_TXT = os.path.join(os.environ['TODO_DIR'], 'future.txt')
    TODO_TXT = os.path.join(os.environ['TODO_DIR'], 'todo.txt')
    futureTasks = get_remove_future(TODO_TXT)
    writeFuture(futureTasks, FUTURE_TXT)
    # writeCurrent()

def writeFuture(tasks, futureTxt):
    with open(futureTxt, "a") as f:
        f.write(''.join(tasks))

def get_remove_future(todoFile):
    futureTasks = []
    otherTasks = []
    with open(todoFile, "r") as f:
     old = f.readlines() # read everything in the file
     f.seek(0) # rewind
     for l in old:
         if FUTURE_TAG in l:
             futureTasks.append(l)
         else:
             otherTasks.append(l)
    with open(todoFile, "w") as f:
        f.write(''.join(otherTasks))
    return futureTasks

if __name__ == "__main__":
    main(sys.argv[1:])
