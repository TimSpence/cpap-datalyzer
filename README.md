CPAP Datalyzer
==============
## Intro
Ingest [European Data Format](https://en.wikipedia.org/wiki/European_Data_Format) data from ResMed Airsense for visualization purposes.

## Usage
At the moment, this project supports two features:
1. Storage of usage data on your host
2. Visualize data using OSCAR


### Commands
Copy nightly usage data from SD card on Linux or Mac systems:
```
rsync -av /path/to/your/SDcard/* data/
```

### Docker
This project relies on Docker to avoid installing dependencies on the host.  If your system can run Docker, you are good to go.

To get started, copy `.env.example` to `.env`.  Then edit `.env` to update your preferences.

Next run OSCAR using `docker compose up`.

View OSCAR in your browser at http://127.0.0.1/.  You may need to click to connect using VNC.

Your SD card will be available at `/airsense`.

When you have finished browsing your data, run `docker compose down` to stop all services.

## Credits
- [rogerrum/docker-oscar](https://github.com/rogerrum/docker-oscar) for Dockerizing OSCAR
- The maintainers of [OSCAR](https://gitlab.com/pholy/OSCAR-code)
- The folks at [Apnea Board](https://www.apneaboard.com/wiki/index.php/OSCAR_-_The_Guide)
