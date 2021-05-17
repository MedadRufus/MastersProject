import unittest
from unittest import TestCase

from battery import Battery


class TestBattery_real(TestCase):
    def setUp(self) -> None:
        self.my_batt = Battery(total_capacity=720)

    @unittest.skip("Not implemented yet")
    def test_update(self):
        self.fail()

    @unittest.skip("Not implemented yet")
    def test_current(self):
        self.fail()

    @unittest.skip("Not implemented yet")
    def test_current(self):
        self.fail()

    @unittest.skip("Not implemented yet")
    def test_voltage(self):
        self.fail()

    @unittest.skip("Not implemented yet")
    def test_state_of_charge(self):
        self.fail()

    @unittest.skip("Not implemented yet")
    def test_OCV_model(self):
        self.fail()

    @unittest.skip("Not implemented yet")
    def test_OCV(self):
        self.fail()
