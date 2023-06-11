using Microsoft.EntityFrameworkCore.Infrastructure;
using System;
using System.Collections.Generic;

#nullable disable

namespace CSD.SensorApp.Data
{
    public partial class Port
    {
        private Sensor m_sensor;

        private ILazyLoader LazyLoader { get; set; }

        private Port(ILazyLoader lazyLoader)
        {
            LazyLoader = lazyLoader;
        }

        public Port()
        {
        }

        public long Id { get; set; }
        public int SensorId { get; set; }
        public int Number { get; set; }

        public virtual Sensor Sensor
        {
            get => LazyLoader.Load(this, ref m_sensor);
            set => m_sensor = value;
        }
    }
}
