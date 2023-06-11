using System;
using System.Threading.Tasks;

namespace CSD.Util.TPL
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

        public static Task<R> Create<R>(Func<R> func)
        {
            var task = new Task<R>(func);

            return task.Create();
        }
    }
}
