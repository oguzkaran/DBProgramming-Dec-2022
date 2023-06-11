using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;

using static CSD.Data.DatabaseUtil;

namespace CSD.Util.Data.Repository
{
    public class CrudRepositoryEx<Entity, ID, Context> : CrudRepository<Entity, ID, Context>, ICrudRepository<Entity, ID>
        where Entity : class, IEntity<ID>
        where Context : DbContext
    {
        public CrudRepositoryEx(Context context) : base(context) { }

        new public IEnumerable<Entity> All => SubscribeRepository(() => base.All, "CrudRepositoryEx.All");

        new public long Count() => SubscribeRepository(() => base.Count(), "CrudRepositoryEx.Count");        

        new public void Delete(Entity entity) => SubscribeRepository(() => base.Delete(entity), "CrudRepositoryEx.Delete");

        new public void DeleteById(ID id) => SubscribeRepository(() => base.DeleteById(id), "CrudRepositoryEx.DeleteById");

        new public bool ExistsById(ID id) => SubscribeRepository(() => base.ExistsById(id), "CrudRepositoryEx.ExistsById");        

        new public Entity FindById(ID id) => SubscribeRepository(() => base.FindById(id), "CrudRepositoryEx.FindById");

        new public IEnumerable<Entity> FindByIds(IEnumerable<ID> ids) => SubscribeRepository(() => base.FindByIds(ids), "CrudRepositoryEx.FindByIds");

        new public Entity Save(Entity entity) => SubscribeRepository(() => base.Save(entity), "CrudRepositoryEx.Save");        

        new public IEnumerable<Entity> Save(IEnumerable<Entity> entities) => SubscribeRepository(() => base.Save(entities), "CrudRepositoryEx.SaveAll");
    }
}
