using CSD.Util.Data.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSD.SensorApp.Data.Repository
{
    public interface IPortRepository : ICrudRepository<Port, long>
    {
    }
}
