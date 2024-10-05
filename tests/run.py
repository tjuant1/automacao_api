from robot import run_cli
import argparse

def parse_args():
    parser = argparse.ArgumentParser(description='Run tests by tag')
    parser.add_argument('--tag')
    return parser.parse_args()

def tag():
    args = parse_args()
    print(f"Tag selecionada:  {args.tag}")
    return args.tag

cli_args = [
        "-d", "../logs",
        "--name", "Serverest Automation",
        "."
]

if tag() != None:
    cli_args.insert((len(cli_args)-1), "--include")
    cli_args.insert((len(cli_args)-1), tag())

run_cli(cli_args)