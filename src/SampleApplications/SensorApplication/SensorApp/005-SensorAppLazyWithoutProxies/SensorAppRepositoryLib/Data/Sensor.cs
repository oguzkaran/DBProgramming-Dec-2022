using Microsoft.EntityFrameworkCore.Infrastructure;
using System;
using System.Collections.Generic;

#nullable disable

namespace CSD.SensorApp.Data
{
    public partial class Sensor //POCO (Plain Old CLR Object)
    {
        private ICollection<Port> m_ports;

        private ILazyLoader LazyLoader { get; set; }

        private Sensor(ILazyLoader lazyLoader)
        {
            LazyLoader = lazyLoader;
        }

        public Sensor()
        {
            Ports = new HashSet<Port>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Host { get; set; }

        public virtual ICollection<Port> Ports 
        {
            get => LazyLoader.Load(this, ref m_ports);
            set => m_ports = value;
        }
    }
}
