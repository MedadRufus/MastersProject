import unittest
from unittest import TestCase

from protocol import Protocol


class TestProtocol(TestCase):
    def setUp(self) -> None:
        self.p = Protocol()

    @unittest.skip("Not implemented yet")
    def test_load_data(self):
        self.fail()

    @unittest.skip("Not implemented yet")
    def test_get_discharge_time(self):
        df = self.p.load_data()
        self.fail()

    @unittest.skip("Not implemented yet")
    def test_launch_experiment_protocol_real_data(self):
        self.fail()
