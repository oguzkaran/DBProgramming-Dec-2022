package org.csystem.app.service.sensor.data.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "sensor_data")
public class SensorData {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sensor_data_id")
    public long id;

    @Column(nullable = false)
    public double value;

    @Column(name = "read_date_time", nullable = false)
    public LocalDateTime readDateTime;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sensor_id", nullable = false)
    //@JsonIgnore
    public Sensor sensor;
    //...
}
