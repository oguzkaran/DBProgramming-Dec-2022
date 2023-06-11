using System;
using System.Threading.Tasks;

namespace CSD.Util.Error
{
    public static class ExceptionUtil
    {
        public static void Subscribe(Action action, Action<Exception> exceptionAction)
        {
            try
            {
                action();
            }
            catch (Exception ex) 
            {
                exceptionAction(ex);
            }
        }

        public static void Subscribe(Action action, Action<Exception> exceptionAction, Action completed)
        {
            try
            {
                action();
            }
            catch (Exception ex)
            {
                exceptionAction(ex);
            }
            finally
            {
                completed();
            }
        }

        public static void Subscribe(Action action, Action completed)
        {
            try
            {
                action();
            }            
            finally
            {
                completed();
            }
        }

        public static async Task SubscribeAsync(Func<Task> func, Func<Exception, Task> exceptionAction)
        {
            try
            {
                await func();
            }
            catch (Exception ex)
            {
                await exceptionAction(ex);
            }
        }

        public static async Task SubscribeAsync(Func<Task> func, Func<Exception, Task> exceptionAction, Func<Task> completed)
        {
            try
            {
                await func();
            }
            catch (Exception ex)
            {
                await exceptionAction(ex);
            }
            finally
            {
                await completed();
            }
        }

        public static async Task SubscribeAsync(Func<Task> func, Func<Task> completed)
        {
            try
            {
                await func();
            }            
            finally
            {
                await completed();
            }
        }


        public static R Subscribe<R>(Func<R> func, Func<Exception, R> exceptionFunc)
        {
            try
            {
                return func();
            }
            catch (Exception ex) {
                return exceptionFunc(ex);
            }
        }

        public static R Subscribe<R>(Func<R> func, Func<Exception, R> exceptionFunc, Action completed)
        {
            try
            {
                return func();
            }
            catch (Exception ex)
            {
                return exceptionFunc(ex);
            }
            finally 
            {
                completed();
            }            
        }

        public static R Subscribe<R>(Func<R> func, Action completed)
        {
            try
            {
                return func();
            }            
            finally
            {
                completed();
            }
        }

        public static async Task<R> SubscribeAsync<R>(Func<Task<R>> func, Func<Exception, Task<R>> exceptionFunc)
        {
            try
            {
                return await func();
            }
            catch (Exception ex)
            {
                return await exceptionFunc(ex);
            }
        }

        public static async Task<R> SubscribeAsync<R>(Func<Task<R>> func, Func<Exception, Task<R>> exceptionFunc, Func<Task> completed)
        {
            try
            {
                return await func();
            }
            catch (Exception ex)
            {
                return await exceptionFunc(ex);
            }
            finally
            {
                await completed();
            }
        }

        public static async Task<R> SubscribeAsync<R>(Func<Task<R>> func, Func<Task> completed)
        {
            try
            {                
                return await func();
            }            
            finally
            {
                await completed();
            }
        }
    }
}
