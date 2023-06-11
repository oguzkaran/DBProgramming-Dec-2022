using CSD.Util.Data.Repository;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;


using static CSD.Util.Async.TaskUtil;

namespace CSD.SensorApp.Data.Repository
{
    public class SensorRepository : CrudRepository<Sensor, int, SensorsDBContext>, ISensorRepository
    {

        #region callbacks
        
        private IEnumerable<Sensor> findByNameCallback(string name)
        {
            return Ctx.Sensors.Where(s => s.Name == name);
        }

        private IEnumerable<Sensor> findByNameContainsCallback(string text)
        {
            return Ctx.Sensors.Where(s => s.Name.Contains(text));
        }       

        public Sensor saveCallback(Sensor sensor)
        {
            Ctx.Sensors.Add(sensor);

            if (Ctx.SaveChanges() != 1)
                throw new Exception("Save problem occurs");

            return sensor;
        }

        public Sensor updateCallback(Sensor sensor)
        {
            var s = Ctx.Sensors.FirstOrDefault(si => si.Id == sensor.Id);

            if (s == null)
                throw new ArgumentException("Update not supported for new sensors");

            s.Name = sensor.Name;
            s.Host = sensor.Host;

            if (Ctx.SaveChanges() != 1)
                throw new Exception("Update problem occurs");
            
            return sensor;
        }

        #endregion

        public SensorRepository()
            : base(new SensorsDBContext())
        {
        }

        #region CRUD Async Methods        

        public Task<IEnumerable<Sensor>> FindByNameAsync(string name)
        {
            return CreateTaskAsync(() => findByNameCallback(name));
        }

        public Task<IEnumerable<Sensor>> FindByNameContainsAsync(string text)
        {
            return CreateTaskAsync(() => findByNameContainsCallback(text));
        }        

        public Task<Sensor> UpdateAsync(Sensor sensor)
        {
            return CreateTaskAsync(() => updateCallback(sensor));
        }

        #endregion

        
    }
}
