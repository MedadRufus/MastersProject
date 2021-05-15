from unittest import TestCase

from main import run_all


class AllTests(TestCase):
    def test_main(self):
        run_all()
