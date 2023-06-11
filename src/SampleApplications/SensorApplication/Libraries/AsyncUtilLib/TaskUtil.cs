using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSD.Util.Async
{
    public static class TaskUtil
    {
        public static Task Create(this Task task)
        {
            task.Start();

            return task;
        }

        public static Task Create(Action func)
        {
            var task = new Task(func);

            return task.Create();
        }

        public static Task<R> Create<R>(this Task<R> task)
        {
            task.Start();

            return task;
        }       

        public static Task<R> CreateTaskAsync<R>(Func<R> func)
        {
            var task = new Task<R>(func);

            return task.Create();
        }

        public static Task<R> CreateTaskAsync<R>(Func<object, R> callback, object obj)
        {
            var task = new Task<R>(callback, obj);
            task.Start();

            return task;
        }

        public static Task CreateTaskAsync(Action<object> callback, object obj)
        {
            var task = new Task(callback, obj);
            task.Start();

            return task;
        }

        public static Task CreateTaskAsync(Action callback)
        {
            var task = new Task(callback);
            task.Start();

            return task;
        }
    }
}
