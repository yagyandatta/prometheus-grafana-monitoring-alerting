# Monitoring Stack with Prometheus, Grafana

This project sets up a comprehensive monitoring stack using Docker Compose. It includes Prometheus for metrics collection, Grafana for visualization and additional exporters for enhanced monitoring capabilities.

## Components

- **Prometheus**: Time series database and monitoring system
- **Grafana**: Visualization and analytics platform
- **Node Exporter**: Hardware and OS metrics exporter
- **Blackbox Exporter**: Probing of endpoints over HTTP, HTTPS, DNS, TCP, and ICMP

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. Clone this repository:
   ```
   git clone https://github.com/yagyandatta/prometheus-grafana-monitoring-alerting.git
   cd prometheus-grafana-monitoring-alerting
   ```

2. You will find the necessary configuration files:
   - `prometheus/prometheus.yml`
   - `docker-compose.yml`

3. Start the stack:
   ```
   docker-compose up -d
   ```

4. Access the services:
   - Prometheus: http://localhost:9090
   - Grafana: http://localhost:3000

## Configuration

### Grafana

Initial login credentials:
- Username: admin
- Password: admin

After first login, you'll be prompted to change the password.

## Volumes

The following persistent volumes are created:
- `prometheus-data`: Stores Prometheus data
- `grafana-data`: Stores Grafana data
- `alertmanager-data`: Stores Alertmanager data

## Customization

You can modify the `docker-compose.yml` file to adjust ports, add more services, or change configuration file locations.

## Troubleshooting

If you encounter any issues:
1. Check the logs of the specific service:
   ```
   docker-compose logs [service_name]
   ```
2. Ensure all required configuration files are present and correctly formatted.
3. Verify that the ports specified in `docker-compose.yml` are not being used by other services on your system.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
