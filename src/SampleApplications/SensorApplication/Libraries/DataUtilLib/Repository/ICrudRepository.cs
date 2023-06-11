using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace CSD.Util.Data.Repository
{
    public interface ICrudRepository<T, ID>
    {
        #region CRUD Operations
        IEnumerable<T> All { get; }

        long Count();

        void Delete(T t);

        void DeleteById(ID id);

        bool ExistsById(ID id);

        IEnumerable<T> FindByFilter(Expression<Func<T, bool>> predicate);

        T FindById(ID id);

        IEnumerable<T> FindByIds(IEnumerable<ID> ids);

        T Save(T t);

        IEnumerable<T> Save(IEnumerable<T> entities);
        #endregion

        #region Async CRUD Operations
        Task<long> CountAsync();

        Task<IEnumerable<T>> FindAllAsync();        

        void DeleteAsync(T t);

        void DeleteByIdAsync(ID id);

        Task<bool> ExistsByIdAsync(ID id);

        Task<IEnumerable<T>> FindByFilterAsync(Expression<Func<T, bool>> predicate);

        Task<T> FindByIdAsync(ID id);

        Task<IEnumerable<T>> FindByIdsAsync(IEnumerable<ID> ids);

        Task<T> SaveAsync(T t);

        Task<IEnumerable<T>> SaveAsync(IEnumerable<T> entities);
        #endregion
    }
}
