from robot import run_cli

tags = ''

run_cli([
         "-d", "../logs",
         "--name", "Serverest Automation",
         "--i", f"{tags}"
         "."
])