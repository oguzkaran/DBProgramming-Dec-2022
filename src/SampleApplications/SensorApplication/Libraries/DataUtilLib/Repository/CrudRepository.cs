using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace CSD.Util.Data.Repository
{
    public abstract class CrudRepository<Entity, ID, Context> : ICrudRepository<Entity, ID>
        where Entity : class, IEntity<ID>
        where Context : DbContext
    {
        private readonly DbSet<Entity> m_entities;

        private Task<IEnumerable<Entity>> findAllAsync()
        {
            var task = new Task<IEnumerable<Entity>>(() => m_entities.ToList());

            task.Start();

            return task;
        }

        private Task<IEnumerable<Entity>> findByFilterAsync(Expression<Func<Entity, bool>> predicate)
        {
            var task = new Task<IEnumerable<Entity>>(() => m_entities.Where(predicate).ToList());

            task.Start();

            return task;
        }

        private Task<bool> existsByIdAsync(ID id)
        {
            var task = new Task<bool>(() => FindByIdAsync(id).Result == default(Entity));

            task.Start();

            return task;
        }        

        protected Context Ctx { get; }

        protected CrudRepository(Context context)
        {
            Ctx = context;
            m_entities = Ctx.Set<Entity>();
        }

        public IEnumerable<Entity> All => m_entities.ToList();

        public long Count() => m_entities.LongCount();        

        public void Delete(Entity entity) => DeleteById(entity.Id);

        public void DeleteById(ID id)
        {          
            var e = FindById(id);

            if (e == null)
                return;

            m_entities.Remove(e);
            Ctx.SaveChanges();
        }

        public bool ExistsById(ID id) => FindById(id) != null;

        public IEnumerable<Entity> FindByFilter(Expression<Func<Entity, bool>> predicate)
            => m_entities.Where(predicate).ToList();


        public Entity FindById(ID id) => m_entities.FirstOrDefault(e => e.Id.Equals(id));        

        public IEnumerable<Entity> FindByIds(IEnumerable<ID> ids)
        {
            throw new NotImplementedException();
        }

        public Entity Save(Entity entity)
        {
            if (ExistsById(entity.Id))
                m_entities.Update(entity);
            else
                m_entities.Add(entity);

            Ctx.SaveChanges();

            return entity;
        }

        public IEnumerable<Entity> Save(IEnumerable<Entity> entities)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<Entity>> FindAllAsync() => findAllAsync();

        public Task<long> CountAsync() => m_entities.LongCountAsync();

        public void DeleteAsync(Entity t) => DeleteByIdAsync(t.Id);        

        public void DeleteByIdAsync(ID id)
        {
            var e = FindByIdAsync(id);

            if (e == null)
                return;

            m_entities.Remove(e.Result);
            Ctx.SaveChangesAsync();
        }

        public Task<bool> ExistsByIdAsync(ID id) => existsByIdAsync(id);

        public Task<IEnumerable<Entity>> FindByFilterAsync(Expression<Func<Entity, bool>> predicate) => findByFilterAsync(predicate);

        public Task<Entity> FindByIdAsync(ID id) => m_entities.FirstOrDefaultAsync(e => e.Id.Equals(id));        

        public Task<IEnumerable<Entity>> FindByIdsAsync(IEnumerable<ID> ids)
        {
            throw new NotImplementedException();
        }

        public Task<Entity> SaveAsync(Entity entity)
        {
            if (ExistsByIdAsync(entity.Id).Result)
                m_entities.Update(entity);
            else
                m_entities.Add(entity);

            var task = new Task<Entity>(() => { Ctx.SaveChangesAsync(); return entity; });

            task.Start();

            return task;
        }        

        public Task<IEnumerable<Entity>> SaveAsync(IEnumerable<Entity> entities)
        {
            throw new NotImplementedException();
        }        
    }
}
