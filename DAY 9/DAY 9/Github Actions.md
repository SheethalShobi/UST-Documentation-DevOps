#### GitHub Actions
A CI/CD tool built into GitHub to automate tasks like testing, building, or deploying code whenever specific events occur (e.g., code push, pull request).

Concept	Description
- Workflow :	A YAML file that defines automation steps (e.g., .github/workflows/main.yml).
- Job	: A set of steps run on the same runner.
- Step :	A single task (run a command or action).
- Runner :	A server that runs workflows (Ubuntu, Windows, macOS).
- Action	: Reusable commands or logic. You can use marketplace actions or write your own.

##### Basic Workflow Structure
```
name: CI Demo Workflow

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Run a script
      run: echo "Hello, GitHub Actions!"

```
###### Trigger Types

- push :	On code push to branches
- pull_request:	On PR creation or update
- schedule:	On a cron schedule (like a timer)
- workflow_dispatch:	Manual trigger from GitHub UI

###### Example
```
name: Python CI

on: [push]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3

    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.10'

    - name: Install dependencies
      run: pip install -r requirements.txt

    - name: Run tests
      run: pytest
```
###### Popular Actions

- actions/checkout : Clone the repo
- actions/setup-node :	Setup Node.js environment
- actions/setup-python :	Setup Python environment
- docker/build-push-action :	Build & push Docker images
- hashicorp/setup-terraform	 : Setup Terraform CLI
