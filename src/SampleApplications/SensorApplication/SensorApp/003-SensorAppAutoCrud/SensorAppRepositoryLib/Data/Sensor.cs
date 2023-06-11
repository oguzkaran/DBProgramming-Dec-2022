using System;
using System.Collections.Generic;

#nullable disable

namespace CSD.SensorApp.Data
{
    public partial class Sensor //POCO (Plain Old CLR Object)
    {
        public Sensor()
        {
            Ports = new HashSet<Port>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Host { get; set; }

        public virtual ICollection<Port> Ports { get; set; }
    }
}
