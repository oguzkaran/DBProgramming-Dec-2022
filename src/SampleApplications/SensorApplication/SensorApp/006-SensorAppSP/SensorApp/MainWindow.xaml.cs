using CSD.SensorApp.Data.DTO;
using CSD.SensorApp.Data.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace SensorApp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private readonly SensorAppService m_sensorAppService;

        public MainWindow(SensorAppService sensorAppService)
        {
            InitializeComponent();
            m_sensorAppService = sensorAppService;
        }

        public MainWindow()
        {
            InitializeComponent();
            Close();
        }

        private void listCallback(IEnumerable<SensorInfoDTO> sensors)
        {
            sensors.ToList().ForEach(si => m_listBoxSensors.Items.Add(si));
        }

        private async void m_buttonList_Click(object sender, RoutedEventArgs e)
        {
            m_listBoxSensors.Items.Clear();
            var sensors = await m_sensorAppService.FindAllSensorsAsync();

            Action action = () => listCallback(sensors);

            if (sensors.Count() == 0)
                action = () => MessageBox.Show("No data yet");

            Dispatcher.Invoke(action);
        }

        private void m_listBoxSensors_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var si = m_listBoxSensors.SelectedItem as SensorInfoDTO;

            m_textBoxSensorName.Text = si.Name;
            m_textBoxSensorHost.Text = si.Host;
        }
        
        private async void m_buttonFind_Click(object sender, RoutedEventArgs e)
        {
            m_listBoxSensors.Items.Clear();
            var sensors = await m_sensorAppService.FindSensorsByNameAsync(m_textBoxName.Text.Trim());

            Action action = () => listCallback(sensors);

            if (sensors.Count() == 0)
                action = () => MessageBox.Show("No data yet");

            Dispatcher.Invoke(action);
        }

        private void m_buttonUpdate_Click(object sender, RoutedEventArgs e)
        {
            if (m_listBoxSensors.SelectedIndex == -1)
                return;

            var sensor = m_listBoxSensors.SelectedItem as SensorInfoDTO;

            sensor.Name = m_textBoxSensorName.Text;
            sensor.Host = m_textBoxSensorHost.Text;
            m_sensorAppService.UpdateSensorAsync(sensor);
        }

        private async void m_buttonSave_Click(object sender, RoutedEventArgs e)
        {
            var sensor = new SensorSaveDTO();

            sensor.Name = m_textBoxSensorName.Text;
            sensor.Host = m_textBoxSensorHost.Text;
            await m_sensorAppService.SaveSensorAsync(sensor);
        }
    }
}
