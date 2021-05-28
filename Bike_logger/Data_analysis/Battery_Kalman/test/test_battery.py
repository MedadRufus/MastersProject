from unittest import TestCase
import unittest
from battery import Battery

class TestBattery(TestCase):
    def setUp(self) -> None:
        capacity = 8.708  # Ah
        discharge_rate = 1  # C
        time_step = 100  # s
        cut_off_voltage = 23

        self.current = capacity * discharge_rate
        self.my_battery = Battery(capacity, 0.062, 0.01, 3000)

    def test_update(self):
        soc = self.my_battery.update(1,10)
        print(soc)
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
    def test_ocv_model(self):
        self.fail()

    @unittest.skip("Not implemented yet")
    def test_ocv(self):
        self.fail()
