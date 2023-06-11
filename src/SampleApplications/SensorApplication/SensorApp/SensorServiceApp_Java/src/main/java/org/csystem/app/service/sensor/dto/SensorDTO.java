package org.csystem.app.service.sensor.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.time.LocalDate;
import java.util.Set;

public class SensorDTO {
    private String m_name;
    private LocalDate m_registerDate;
    private int m_port;

    public String getName()
    {
        return m_name;
    }

    public void setName(String name)
    {
        m_name = name;
    }

    public LocalDate getRegisterDate()
    {
        return m_registerDate;
    }

    @JsonFormat(pattern = "dd/MM/yyyy")
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public void setRegisterDate(LocalDate registerDate)
    {
        m_registerDate = registerDate;
    }

    public int getPort()
    {
        return m_port;
    }

    public void setPort(int active)
    {
        m_port = active;
    }
}
