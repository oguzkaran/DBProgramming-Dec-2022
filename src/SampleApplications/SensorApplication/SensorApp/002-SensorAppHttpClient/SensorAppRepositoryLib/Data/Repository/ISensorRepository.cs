using CSD.Util.Data.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSD.SensorApp.Data.Repository
{
    public interface ISensorRepository : ICrudRepository<Sensor, int>
    {
        Task<IEnumerable<Sensor>> FindByNameAsync(string name);
        Task<IEnumerable<Sensor>> FindByNameContainsAsync(string text);
        public Task<Sensor> UpdateAsync(Sensor sensor);

        Task<IEnumerable<SensorInfo>> FindAllSensorInfoAsync();


    }
}
