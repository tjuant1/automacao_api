import argparse

def parse_args():
    parser = argparse.ArgumentParser(description='Run tests by tag')
    parser.add_argument('--tag')
    parser.add_argument('--robot')

    return parser.parse_args()

def tag():
    args = parse_args()
    print(f"Tag selecionada:  {args.tag}")

    return args.tag

def robot_execution():
    args = parse_args()
    print("Execução padrão do robot")

    return args.robot