package org.csystem.app.service.sensor.data.entity;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Set;

@Entity
@Table(name = "sensors")
public class Sensor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sensor_id")
    public int id;

    @Column(nullable = false /*unique = true*/)
    public String name;

    @Column(name = "register_date", nullable = false)
    public LocalDate registerDate = LocalDate.now();

    @Column(name = "port", nullable = false)
    public int port;

    @Column(length = 1024)
    public String description;

    @OneToMany(mappedBy = "sensor", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    public Set<SensorData> sensorData;

    //...
}
