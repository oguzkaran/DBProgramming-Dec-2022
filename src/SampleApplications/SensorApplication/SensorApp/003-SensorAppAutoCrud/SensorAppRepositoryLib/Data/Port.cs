using System;
using System.Collections.Generic;

#nullable disable

namespace CSD.SensorApp.Data
{
    public partial class Port
    {
        public long Id { get; set; }
        public int SensorId { get; set; }
        public int Number { get; set; }

        public virtual Sensor Sensor { get; set; }
    }
}
