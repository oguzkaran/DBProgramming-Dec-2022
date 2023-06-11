using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSD.SensorApp.Data.DTO
{
    public class SensorInfoDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Host { get; set; }

        public override string ToString() => Name;        
    }
}
