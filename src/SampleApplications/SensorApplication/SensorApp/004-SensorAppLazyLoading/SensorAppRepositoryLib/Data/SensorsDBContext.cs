using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace CSD.SensorApp.Data
{
    public partial class SensorsDBContext : DbContext
    {
        public SensorsDBContext()
        {
        }

        //public SensorsDBContext(DbContextOptions<SensorsDBContext> options)
        //    : base(options)
        //{
        //}

        public virtual DbSet<Port> Ports { get; set; }
        public virtual DbSet<Sensor> Sensors { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (optionsBuilder.IsConfigured)
                return;

            optionsBuilder
                .UseLazyLoadingProxies() //Proxy kullanarak lazy loading enable yapıldı
                .UseSqlServer("Server = aws-mssql.cct1ehgoywdp.us-east-2.rds.amazonaws.com; Database = Algaj22_SensorsDB; User Id = admin; Password = csystem1993;");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Port>(entity =>
            {
                entity.ToTable("Port");

                entity.HasOne(d => d.Sensor)
                    .WithMany(p => p.Ports)
                    .HasForeignKey(d => d.SensorId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Port__SensorId__38996AB5");
            });

            modelBuilder.Entity<Sensor>(entity =>
            {
                entity.ToTable("Sensor");

                entity.Property(e => e.Host)
                    .IsRequired()
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .IsFixedLength(true);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(256);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
