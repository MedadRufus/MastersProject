from unittest import TestCase

from data_manager import load_data
from main import SocEstimator


class AllTests(TestCase):
    def setUp(self) -> None:
        df = load_data()

        self.soc_estimator = SocEstimator(df)

    def test_main(self):
        self.soc_estimator.run_all()
