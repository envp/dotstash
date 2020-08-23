import sys
import json
import logging

def readSystemDefaults():
    logging.info("Reading system defaults")
    if "darwin" in sys.platform.lower():
        output = ShellCommand(["defaults", "read", "-g"]).run()
    return {}
