using CSD.Util.Data.Repository;
using CSD.Util.Data.Service;
using System;
using System.Threading.Tasks;

namespace CSD.Data
{
    public static class DatabaseUtil
    {

        public static void SubscribeRepository(Action action, string message)
        {
            try
            {
                action();
            }
            catch (Exception ex)
            {
                throw new RepositoryException(message, ex);
            }
        }

        public static async Task SubscribeRepositoryAsync(Func<Task> func, string message)
        {
            try
            {
                await func();
            }
            catch (Exception ex)
            {
                throw new RepositoryException(message, ex);
            }
        }

        public static R SubscribeRepository<R>(Func<R> func, string message)
        {
            try
            {
                return func();
            }
            catch (Exception ex) {
                throw new RepositoryException(message, ex);
            }
        }

        public static async Task<R> SubscribeRepositoryAsync<R>(Func<Task<R>> func, string message)
        {
            try
            {
                return await func();
            }
            catch (Exception ex)
            {
                throw new RepositoryException(message, ex);
            }
        }       

        public static void SubscribeService(Action action, string message)
        {
            try
            {
                action();
            }
            catch (RepositoryException ex)
            {
                throw new DataServiceException(message, ex.InnerException);
            }
            catch (Exception ex) {
                throw new DataServiceException(message, ex);
            }
        }

        public static async Task SubscribeAsync(Func<Task> func, string message)
        {
            try
            {
                await func();
            }
            catch (RepositoryException ex)
            {
                throw new DataServiceException(message, ex.InnerException);
            }
            catch (Exception ex)
            {
                throw new DataServiceException(message, ex);
            }
        }

        public static async Task SubscribeServiceAsync(Func<Task> func, string message)
        {
            try
            {
                await func();
            }
            catch (RepositoryException ex)
            {
                throw new DataServiceException(message, ex.InnerException);
            }
            catch (Exception ex)
            {
                throw new DataServiceException(message, ex);
            }
        }

        public static async Task<R> SubscribeServiceAsync<R>(Func<Task<R>> func, string message)
        {
            try
            {
                return await func();
            }
            catch (RepositoryException ex)
            {
                throw new DataServiceException(message, ex.InnerException);
            }
            catch (Exception ex)
            {
                throw new DataServiceException(message, ex);
            }
        }
    }
}
