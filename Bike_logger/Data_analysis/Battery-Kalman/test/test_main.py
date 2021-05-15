from unittest import TestCase

from main import SocEstimator


class AllTests(TestCase):
    def setUp(self) -> None:
        self.soc_estimator = SocEstimator()

    def test_main(self):
        self.soc_estimator.run_all()
