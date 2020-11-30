import logging
import time
from datetime import datetime
from pathlib import Path

import requests
import schedule

import logger

logger.initialize_default(force_console_output=True).setLevel(logging.INFO)
file_handler = logger.log_to_file("test.log")
file_handler.setLevel(logging.DEBUG)

LOG_FORMAT_CUSTOM = '%(asctime)s| %(levelname)s : %(message)s'  # noqa

logger.set_colors(False, LOG_FORMAT_CUSTOM)
logger.set_unhandled_exception_handler()

sites_to_scrape = {"helbiz": {"url": "https://api.helbiz.com/admin/reporting/washington/gbfs/all_bike_status.json"},
                   "bird": {"url": "https://gbfs.bird.co/dc"}
                   }

HOW_OFTEN_TO_SCRAPE = 30 # every 10 seconds

def job():

    file_time = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")

    p = Path("datadump/")
    p.mkdir(parents=True, exist_ok=True)

    for site in sites_to_scrape:
        logger.info("Scraping site: {}".format(site))

        response = requests.get(sites_to_scrape[site]["url"])
        file_name = '{0}_{1}.json'.format(site,file_time)
        filepath = p / file_name
        filepath.write_bytes(response.content)



for i in range(0, 60, HOW_OFTEN_TO_SCRAPE):
    time_str = f":{i:02}"
    logger.info(time_str)
    schedule.every().minute.at(time_str).do(job)

if __name__ == "__main__":
    logger.info("Started Scraper")
    while True:
        schedule.run_pending()
        time.sleep(1)
