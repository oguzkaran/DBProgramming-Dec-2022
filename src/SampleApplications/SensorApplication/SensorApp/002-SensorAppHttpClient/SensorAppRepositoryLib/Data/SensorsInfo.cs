using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSD.SensorApp.Data
{
    public class SensorInfo
    {
        public string Name { get; set; }
        public bool Active { get; set; }
        public string RegisterDate { get; set; }
    }
    public class SensorsInfo
    {
        public List<SensorInfo> Sensors { get; set; }        
    }
}
